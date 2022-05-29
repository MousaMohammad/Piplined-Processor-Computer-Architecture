#include<iostream>
#include<vector>
#include<map>
#include<string>
#include<fstream>
using namespace std;

const int nopOpCode = 0b101000;
const int hltOpCode = 0b101100;
const int setcOpCode = 0b011100;
const int callOpCode = 0b010010;
const int pushOpCode = 0b010001;
const int popOpCode = 0b010101;
const int retOpCode = 0b010110;
const int rtiOpCode = 0b011110;
const int intOpCode = 0b011010;
const int outOpCode = 0b100000;
const int inOpCode = 0b100100;
const int movOpCode = 0b010100;
const int ldmOpCode = 0b000101;
const int swapOpCode = 0b011000;
const int jmpOpCode = 0b000010;
const int jzOpCode = 0b000110;
const int jnOpCode = 0b001010;
const int jcOpCode = 0b001110;
const int stdOpCode = 0b001101;
const int notOpCode = 0b000000;
const int incOpCode = 0b000100;
const int addOpCode = 0b001000;
const int subOpCode = 0b001100;
const int andOpCode = 0b010000;
const int iaddOpCode = 0b000001;
const int lddOpCode = 0b001001;


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



void memMode()
{
	int evenCounter = 0;
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


	string memHeader = "// memory data file (do not edit the following line - required for mem load use)\n";
	memHeader += "// instance=/memory/ram\n";
	memHeader += "// format=bin addressradix=h dataradix=b version=1.0 wordsperline=2\n";

	ifstream assemblyCode("input.txt");
	ofstream machineCode("machine code.mem");
	machineCode << memHeader;
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
		instruction.replace(0, 6, decimalToBinary(opCode, 6));

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
			instruction.replace(9, 3, decimalToBinary(Rsrc1, 3));
			break;

		case popOpCode:
			Rdst = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(9, 3, decimalToBinary(Rdst, 3));
			break;

		case retOpCode:
			break;
		case rtiOpCode:
			break;

		case intOpCode:
			instruction.replace(31, 1, line.substr(line.size() - 1, 1));
			break;

		case outOpCode:
			Rsrc1 = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(12, 3, decimalToBinary(Rsrc1, 3));
			break;

		case inOpCode:
			Rdst = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(12, 3, decimalToBinary(Rdst, 3));
			break;

		case movOpCode:
			Rsrc1 = stoi(line.substr(5, 1));
			Rdst = stoi(line.substr(line.size() - 1, 1));
			instruction.replace(12, 3, decimalToBinary(Rdst, 3));
			instruction.replace(6, 3, decimalToBinary(Rsrc1, 3));
			break;

		case ldmOpCode:
			Rdst = stoi(line.substr(5, 1));
			instruction.replace(5, 3, decimalToBinary(Rdst, 3));

			immediateValue = line.substr(8,line.size() -8) == " "? stoi(line.substr(7, line.size() - 7)) :stoi(line.substr(8, line.size() - 8));
			
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
		if (evenCounter % 2 == 0) 
		{
			machineCode << "    @" << std::hex << evenCounter << " ";
			machineCode << instruction;
		}
		else 
		{ 
			machineCode << " "; 
			machineCode << instruction << endl;
		}
		evenCounter++;
	}

	assemblyCode.close();
	machineCode.close();

}

int main()
{


	memMode();
	return 0;

}
//01234567890123
//std r1, 16(r2)
//opcode  rdst  rsrc1  rsrc2    immediate
//01234   567   890    123   45 6789012345678901


