# this is for Leetcode 736. Parse Lisp Expression
# https://leetcode.com/problems/parse-lisp-expression/

class Parser(object):
    def __init__(self, expr):
        self.expr = expr
        self.idx = 0
        self.N = len(expr)

    def peek(self, exp):
        return self.expr[self.idx: self.idx+len(exp)] == exp

    def consume(self, exp):
        if self.peek(exp):
            self.idx += len(exp)
        else:
            raise ValueError('exp %s does not match' %exp)

    def parseNext(self):
        if self.peek('(add '):
            self.consume('(add ')
            left = self.parseNext()
            self.consume(' ')  # space
            right = self.parseNext()
            if self.idx < self.N:
                self.consume(')')
            return {
                'type': 'ADD',
                'left': left,
                'right': right
            }
        if self.peek('(mult '):
            self.consume('(mult ')
            left = self.parseNext()
            self.consume(' ')  # space
            right = self.parseNext()
            if self.idx < self.N:
                self.consume(')')
            return {
                'type': 'MULT',
                'left': left,
                'right': right
            }
        if self.peek('(let '):
            self.consume('(let ')
            # must have at least one var
            var = self.parseNext()
            self.consume(' ')  # space
            exp = self.parseNext()
            if var['type'] != 'VAR':
                raise TypeError('the first exp after let must be var')
            _vars = []
            _vars.append({'name': var['text'], 'value': exp})
            self.consume(' ')  # space
            
            # have one or more char
            while True:
                var_or_exp = self.parseNext()
                if var_or_exp['type'] == 'VAR':
                    # in most cases, this means a new var, but a var may also
                    # be the last expression of the let expression
                    if self.peek(')'):  # last expr
                        self.consume(')')
                        return {
                            'type': 'LET',
                            '_vars': _vars,
                            'text': var_or_exp
                        }
                    self.consume(' ')
                    _vars.append({'name': var_or_exp['text'], 'value': self.parseNext()})
                    self.consume(' ')
                else:
                    if self.idx < self.N:
                        self.consume(')')
                    return {
                        'type': 'LET',
                        '_vars': _vars,
                        'text': var_or_exp
                    }
        elif self.expr[self.idx].isdigit() or self.expr[self.idx] == '-':
            idx = self.idx
            i = idx + 1
            while i < self.N and self.expr[i].isdigit():
                i += 1
            self.idx = i
            # print(self.idx, self.expr, self.expr[idx:self.idx])
            return {
                'type': 'INT',
                'text': self.expr[idx:self.idx]
            }
        elif self.expr[self.idx].isalpha():
            idx = self.idx
            i = idx
            while i < self.N and self.expr[i].isalnum():
                i += 1
            self.idx = i
            return {
                'type': 'VAR',
                'text': self.expr[idx:self.idx]                
            }

class Compiler(object):
    def run(self, ast, frameStack=None):
        _type = ast['type']
        if _type == 'INT':
            return int(ast['text'])
        if _type == 'VAR':
            if not frameStack:
                raise ValueError('should have saved value')
            for frame in frameStack[::-1]:
                if ast['text'] in frame:
                    return frame[ast['text']]
            raise ValueError('cannot find the var in frameStack', ast['text'], frameStack)
        if _type == 'ADD':
            return self.run(ast['left'], frameStack) + self.run(ast['right'], frameStack)
        if _type == 'MULT':
            return self.run(ast['left'], frameStack) * self.run(ast['right'], frameStack)
        if _type == 'LET':
            _vars = ast['_vars']
            frame = {}
            if not frameStack:
                frameStack = []
            frameStack.append(frame)
            for item in _vars:
                value = self.run(item['value'], frameStack)
                frame[item['name']] = value
            value = self.run(ast['text'], frameStack)
            frameStack.pop()
            return value

class Solution(object):
    def evaluate(self, expression):
        """
        :type expression: str
        :rtype: int
        """
        parser = Parser(expression)
        root = parser.parseNext()
        # print_ast(root)
        compiler = Compiler()
        return compiler.run(root)

if __name__ == "__main__":
    sol = Solution()
    assert sol.evaluate('(add 1 2)') == 3
    assert sol.evaluate('(mult 3 (add 2 3))') == 15
    assert sol.evaluate('(let x 2 (mult x 5))') == 10
    assert sol.evaluate('(let x 2 (mult x (let x 3 y 4 (add x y))))') == 14
    assert sol.evaluate('(let x 3 x 2 x)') == 2
    assert sol.evaluate('(let x 1 y 2 x (add x y) (add x y))') == 5
    assert sol.evaluate('(let x 2 (add (let x 3 (let x 4 x)) x))') == 6
    assert sol.evaluate('(let a1 3 b2 (add a1 1) b2)') == 4
    assert sol.evaluate('(let x 3 -12)') == -12


# def print_ast(root, indent=0):
#     type = root['type']
#     if type == 'ADD':
#         print(' '*indent, 'ADD')
#         print(' '*indent, 'left: ')
#         print_ast(root['left'], indent+2)
#         print(' '*indent, 'right: ')
#         print_ast(root['right'], indent+2)
#     elif type == 'INT' or type == 'VAR':
#         print(' '*indent + type + root['text'])
