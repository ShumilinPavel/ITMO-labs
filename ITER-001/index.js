class Iterable {
    constructor(numbersCount) {
        this.numbersCount = numbersCount;
    }

    [Symbol.iterator]() {
        return {
            numbersCount: this.numbersCount,
            alreadyGeneratedNumbersCount: 0,

            next() {
                const generateNextNumber = () => {
                    this.alreadyGeneratedNumbersCount++;
                    let numStr = (Math.random() * 2).toFixed(2);

                    if (parseInt(numStr[3]) % 2 == 0) {
                        return numStr;
                    }
                    else {
                        const evenDigits = ['0', '2', '4', '6', '8'];
                        const randomIndex = Math.floor(Math.random() * evenDigits.length);
                        return numStr.substr(0, 3).concat(evenDigits[randomIndex]);
                    }
                }
                
                if (this.alreadyGeneratedNumbersCount < this.numbersCount) {
                    const nextNumber = generateNextNumber();
                    return { done: false, value: nextNumber};
                }
                else {
                    return { done: true };
                }
            }
        }
    }
};

const it = new Iterable(3);
console.log([...it])
