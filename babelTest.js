const babel = require('@babel/core');
const parser = require('@babel/parser')

const code = 'const n = 1';

const ast = parser.parse(code);
console.log(ast);

const output = babel.transformSync(code, {
  plugins: [
    function myCustomPlugin() {
      return {
        visitor: {
          Identifier(path) {
            if (path.isIdentifier({ name: 'n' })) {
              path.node.name = 'x';
            }
          },
          RecordExpression(path) {
              path.insertBefore(t.expressionStatement(t.stringLiteral("Because I'm easy come, easy go.")));
          }
        },
      };
    },
  ],
});

console.log(output.code); // 'const x = 1;'