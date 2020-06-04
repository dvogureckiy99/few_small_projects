#include <iostream>
#include <string>
#include <locale>
#include <sstream>
#include <cstdlib>


using namespace std;

class InputStopChecker22 {
private:
	locale loc;      //
	int numeral_sum; // сумма цифр в строке
public:
	InputStopChecker22() 
	{
		numeral_sum = 0;
	}
	bool checkStopCondition() 
	{
		if (numeral_sum > 100) {return true;}
		else 
		{
			return false;
		}
	}
	void handleLine(string & line) {
		for (int i = 0; i < line.size(); i++) {
			if ('0' <= line[i] && line[i] <= '9') {
				int digit = line[i] - '0';
				numeral_sum += digit;
			}
		}
	}
};

class InputHandler23 {
private:
	int simbol_counter;
	string output; 
public:
	InputHandler23() {
		simbol_counter = 0;
		output = "";
	}
	void handleLine(string & line) {
		if (simbol_counter < 100) {
			for (int i = 0; i < line.size(); i++) {
				if (simbol_counter < 100) {
					if (line[i] != ' ' && line[i] != '\n' && line[i] != '\t') {
						simbol_counter++;
					}
					
					output += line[i];
				}
				else {
					break;
				}
			}
			output += '\n';
		}
	}
	string getOutput() { return output; }
};

class ConsoleOutputHandler {
public:
	void handleOutput(string & output) {
		cout << output;
	}
};

void handleInput(istream & istream, ostream & ostream, InputStopChecker22* checker, InputHandler23* handler, ConsoleOutputHandler* output) {
	cout << "===Please enter no more than 25 string with length no more than 100." << endl;
	bool stopped = false;
	int line_counter = 0;
	while (!stopped) {
		string line;
		getline(istream, line);
		cout << "Length of line : " << line.length() << endl;
		if (line.length() > 100) {
			ostream << "===Your line have length more than 100 character it will be resised to maximal length 100." << endl;
			line.resize(100);
		}
		handler->handleLine(line);
		checker->handleLine(line);
		line_counter++;
		if (checker->checkStopCondition()) {
			ostream << "===Sum of numbers in your input more than 100 input stopped." << endl;
			stopped = true;
		}
		if (!stopped && line_counter == 25) {
			ostream << "===You entered 25 strings. Input stopped." << endl;
			stopped = true;
		}
	}
	ostream << "===Start output." << endl;
	string out = handler->getOutput();
	cout << "Length of line : " << out.length() << endl;
	output->handleOutput(out);
	ostream << "===Output finished." << endl;
}

int main() {

	InputStopChecker22 checker;
	InputHandler23 handler;
	ConsoleOutputHandler output;

	handleInput(cin, cout, &checker, &handler, &output);
	system("pause");
	return 0;
}



	
	







