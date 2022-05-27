#include<iostream>
#include<vector>
#include<map>
#include<string>
#include<fstream>
using namespace std;

const int nopOpCode = 0;
const int hltOpCode = 1;
const int setcOpCode = 2;
const int callOpCode = 3;
const int pushOpCode = 4;
const int popOpCode = 5;
const int retOpCode = 6;
const int rtiOpCode = 7;
const int intOpCode = 8;
const int outOpCode = 9;
const int inOpCode = 10;
const int movOpCode = 11;
const int ldmOpCode = 12;
const int swapOpCode = 13;
const int jmpOpCode = 14;
const int jzOpCode = 15;
const int jnOpCode = 16;
const int jcOpCode = 17;
const int stdOpCode = 18;
const int notOpCode = 19;
const int incOpCode = 20;
const int addOpCode = 21;
const int subOpCode = 22;
const int andOpCode = 23;
const int iaddOpCode = 24;
const int lddOpCode = 25;





string decimalToBinary(int decimal, int binarySize)
{
	string binary = "";
	while (decimal > 0)
	{
		binary = (decimal % 2 == 0 ? "0" : "1") + binary;
		decimal /= 2;
	}
	while (binary.size() < binarySize)
		binary = "0" + binary;
	return binary;
}

int main()
{

	map<string, int> commands = {
		{"nop", nopOpCode},
		{"hlt", hltOpCode},
		{"setc", setcOpCode},
		{"call", callOpCode},
		{"push", pushOpCode},
		{"pop", popOpCode},
		{"ret", retOpCode},
		{"rti", rtiOpCode},
		{"int", intOpCode},
		{"out", outOpCode},
		{"in", inOpCode},
		{"mov", movOpCode},
		{"ldm", ldmOpCode},
		{"swap", swapOpCode},
		{"jmp", jmpOpCode},
		{"jz", jzOpCode},
		{"jn", jnOpCode},
		{"jc", jcOpCode},
		{"std", stdOpCode},
		{"not", notOpCode},
		{"inc", incOpCode},
		{"add", addOpCode},
		{"sub", subOpCode},
		{"and", andOpCode},
		{"iadd", iaddOpCode},
		{"ldd", lddOpCode}
	};


	ifstream assemblyCode("input.txt");
	ofstream machineCode("machine code.txt");
	string line;
	while (getline(assemblyCode, line))
	{
		//convert line to small case
		for (int i = 0; i < line.size(); i++)
			line[i] = tolower(line[i]);

		string operation;
		//if operation is 2 chars
		if (line.substr(0, 2) == "in" || line.substr(0, 2) == "jz" ||
			line.substr(0, 2) == "jn" || line.substr(0, 2) == "jc")
		{
			operation = line.substr(0, 2);
		}
		//else if operation is 4 chars
		else if (line.substr(0, 4) == "setc" || line.substr(0, 4) == "call"
			|| line.substr(0, 4) == "push" || line.substr(0, 4) == "swap" || line.substr(0, 4) == "iadd")
		{
			operation = line.substr(0, 4);
		}
		//else operation is 3 chars
		else
		{
			operation = line.substr(0, 3);
		}
		int opCode = commands[operation];

		string instruction;
		instruction = "00000000000000000000000000000000";
		instruction.replace(0, 5, decimalToBinary(opCode, 5));

		int immediateValue = 0;
		int Rdst = 0;
		int Rsrc1 = 0;
		int Rsrc2 = 0;

		switch (opCode)
		{
		case nopOpCode:
			break;
		case hltOpCode:
			break;
		case setcOpCode:
			break;

		case callOpCode:
			immediateValue = stoi(line.substr(5, line.size() - 5));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case pushOpCode:
			Rsrc1 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case popOpCode:
			Rdst = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			break;

		case retOpCode:
			break;
		case rtiOpCode:
			break;

		case intOpCode:
			instruction.replace(5, 1, line.substr(line.size() - 1, 1));
			break;

		case outOpCode:
			Rsrc1 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case inOpCode:
			Rdst = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			break;

		case movOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case ldmOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));

			immediateValue = stoi(line.substr(8, line.size() - 8));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case swapOpCode:
			Rdst = stoi(line.substr(6, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case jmpOpCode:
			immediateValue = stoi(line.substr(4, 1));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case jzOpCode:
			immediateValue = stoi(line.substr(3, 1));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case jnOpCode:
			immediateValue = stoi(line.substr(3, 1));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case jcOpCode:
			immediateValue = stoi(line.substr(3, 1));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		//01234567890123
		//std r1, 16(r2)
		case stdOpCode:
			Rsrc1 = stoi(line.substr(5, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			Rsrc2 = stoi(line.substr(line.size() - 2, 1));
			instruction.replace(11, 3, decimalToBinary(Rsrc2, 3));
			immediateValue = stoi(line.substr(8, line.size() - 4 - 8));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;

		case notOpCode:
			Rdst = Rsrc1 = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case incOpCode:
			Rdst = Rsrc1 = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			break;

		case addOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(9, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			Rsrc2 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(11, 3, decimalToBinary(Rsrc2, 3));
			break;

		case subOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(9, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			Rsrc2 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(11, 3, decimalToBinary(Rsrc2, 3));
			break;

		case andOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(9, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			Rsrc2 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(11, 3, decimalToBinary(Rsrc2, 3));
			break;
		
		case iaddOpCode:
			Rdst = stoi(line.substr(6, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(10, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			immediateValue = stoi(line.substr(13, line.size() - 13));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;
		
		case lddOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));
			Rsrc1 = stoi(line.substr(line.size() - 2, 1));
			instruction.replace(8, 3, decimalToBinary(Rsrc1, 3));
			immediateValue = stoi(line.substr(8, line.size() - 4 - 8));
			instruction.replace(16, 16, decimalToBinary(immediateValue, 16));
			break;
		}

		//Write instruction in machine code file
		machineCode << instruction << endl;

	}

	assemblyCode.close();
	machineCode.close();

	return 0;
}
//01234567890123
//std r1, 16(r2)
//opcode  rdst  rsrc1  rsrc2    immediate
//01234   567   890    123   45 6789012345678901


