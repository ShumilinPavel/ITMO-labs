// effector подключается скриптом из kodaktor
const { createStore, createEvent } = effector

const maxPageNumber = 141;  
const s = document.querySelector('#s');
const f = document.querySelector('#f');  
const prv = document.querySelector('#prv');
const nxt = document.querySelector('#nxt');
const scro = () => self.scrollTo(0,0);  

const page = createStore(1);

const nextPage = createEvent();
const previousPage = createEvent();
const setPage = createEvent();

page
.on(nextPage, state => state >= maxPageNumber ? state : ++state)
.on(previousPage, state => state <= 1 ? state : --state)
.on(setPage, (_, newPage) => newPage);

page.watch(page => {
  setTimeout(scro, 10);

  location.hash = page;
  
  const pageStr = String(page).padStart(2, "0");
  const url = `/gossbook_slides/gossbook-${pageStr}.png`; // `
  f.src = url;  
  s.value = page;
  
  const prevPageStr = page - 1 >= 1 ? String(page - 1).padStart(2, "0") : "01";
  const prevUrl = `/gossbook_slides/gossbook-${prevPageStr}.png`; // `
  prv.setAttribute("href", prevUrl);

  const nextPageStr = page + 1 <= maxPageNumber ? String(page + 1).padStart(2, "0") : String(maxPageNumber);
  const nextUrl = `/gossbook_slides/gossbook-${nextPageStr}.png`; // `
  nxt.setAttribute("href", nextUrl);
})

for(let i = 1; i <= maxPageNumber; ++i) {
    s
    .appendChild(document.createElement('option'))
    .appendChild(document.createTextNode(i));
}

s.addEventListener('input', e => {
  setPage(e.target.value);
});

prv.addEventListener('click', e => {
  previousPage();
}); 

nxt.addEventListener('click', e => {
  nextPage();
});  