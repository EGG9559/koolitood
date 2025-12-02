#include <iostream>
using namespace std;

int main() {

    char op;
    float num1, num2;

    cout << "Enter operator: +, -, *, /: ";
    cin >> op;

    cout << "Enter two operands: ";
    cin >> num1 >> num2;

    switch(op) {
        case '+':
            cout << num1 << " + " << num2 << " = " << num1 + num2;
            break;

        case '-':
            cout << num1 << " - " << num2 << " = " << num1 - num2;
            break;

        case '*':
            cout << num1 << " * " << num2 << " = " << num1 * num2;
            break;

        case '/':
            if (num2 != 0)
                cout << num1 << " / " << num2 << " = " << num1 / num2;
            else
                cout << "Error! Division by zero.";
            break;

        default:
            cout << "Error! Operator is not correct";
            break;
    }

    // Wait for user input before closing
    cout << "\n\nPress Enter to exit...";
    cin.ignore(); // Clear any leftover newline from previous cin
    cin.get();    // Wait for user to press Enter

    return 0;
}