//
//  Algo.m
//  BooleanFunctionsSimplifier
//
//  Created by Nikita Belosludcev on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Algo.h"
#include <vector>
#include <string>
#include <stdlib.h>
#include <iostream>
@implementation Algo
@synthesize finalArray;
using namespace std;

int MIN_BITS = 3;		//minimum bits to print
vector<unsigned> input_values;	
bool show_mid = true;		//show middle process5

struct B_number{
unsigned number;
unsigned dashes;
bool used;
};

vector<vector<B_number> > table;	//original table
vector<vector<B_number> > p_group;	//mid process table
vector<vector<B_number> > final_group;	//final table
vector<B_number> printed_numbers; //avoid printing the same final numbers 

//----------------------------------------------------------
unsigned count_1s(unsigned number); //count the number of 1s in a number
void print_binary(unsigned number);//print the number in binary
void create_table();		//create original table sorted by the number of 1s
void print_table();		//print the table
B_number init_B_number(unsigned n,int d, bool u);//initialize a B_number
void create_p_group();		//create mid process table
void print_p_group();		//print it
void print_p_binary(unsigned n, unsigned d);//print the mid table (with -'s)
void create_final_group();		//create final table
void print_final_group();		//print final table with -'s and unused terms
bool is_printed(B_number n);		//dont print terms that were already printed
void init();				//start the table making and printing
void getinput();			//get input from user
unsigned count_bits(unsigned n);	//min bits to represent a number
//----------------------------------------------------------


/* counts 1s by getting the LSB (%2) and then shifting until 0 */
unsigned count_1s(unsigned number) {
	short bit =0;
	int count = 0;
	while(number>0)	{
		bit = number%2;
		number>>=1;
		if(bit) {
			count++;
		}
	}
	return count;
}

/*creating first table: append current number to the array located in
 table[number of 1s f this number]*/
void create_table() {
	short tmp;
	B_number temp_num;
	for(int i=0;i<input_values.size();i++) {
		tmp = count_1s(input_values[i]);
		if(tmp+1>table.size())
			table.resize(tmp+1);
		
		temp_num = init_B_number(input_values[i],0,false);
		table[tmp].push_back(temp_num);
	}
}


/* initialize a B_number variable - like a constructor */
B_number init_B_number(unsigned	n,int d, bool u) {
	B_number num;
	num.number = n;
	num.dashes = d;
	num.used = u;
	return num;
}
/*like the original table, but the paring of numbers from the original table-
 dashes are represented by a 1. for example original A=0011 B=1011, new number 
 is -011 which is represented as C.number=A&B=0011,C.dashes=A^B=1000*/
void create_p_group() {
	short tmp;
	B_number temp_num;
	unsigned temp_number, temp_dashes;
	for(int i=0;i<table.size()-1;i++) {
		for(int j=0;j<table[i].size();j++) {
			for(int k=0;k<table[i+1].size();k++) {
				temp_number = table[i][j].number & table[i+1][k].number;
				temp_dashes = table[i][j].number ^ table[i+1][k].number;
				
				if(count_1s(temp_dashes)==1) {
					table[i][j].used = true;
					table[i+1][k].used = true;
					
					
					tmp = count_1s(temp_number);
					
					if(tmp+1>p_group.size())
						p_group.resize(tmp+1);
					
					temp_num = init_B_number(temp_number, temp_dashes, false);
					p_group[tmp].push_back(temp_num);
				}
			}
		}
	}
}
-(void) addBinary:(unsigned)n dashes:(unsigned )d{
	unsigned bits[MIN_BITS];
	int count = 0;
	
	while(n>0||count<MIN_BITS) {
		if(!(d%2))
			bits[count] = n%2;
		else
			bits[count] = 2;
		
		n >>= 1;
		d >>= 1;
		count++;
	}
    NSMutableString *string=[[NSMutableString alloc] init];
	for(int i=count-1;i>=0;i--) {
		if(bits[i]!=2)
			[string appendString:[NSString stringWithFormat:@"%i",bits[i]]];
		else
            [string appendString:@"-"];
	}
    [finalArray addObject:string];
}
/*creates final table. works like p_group(). example; in p_group you have: 
 A=-001 B=-011 -> C= -0-1 which will be represented as 
 C.number=A&B=0001&0011=0001, and C.dashes=A^B^A.dashes=0001^0011^1000=1010. 
 Computation is done only when A.dashes = b.dashes*/
void create_final_group() {
	short tmp;
	B_number temp_num;
	unsigned temp_number, temp_dashes;
	for(int i=0;i<p_group.size()-1;i++) {
		for(int j=0;j<p_group[i].size();j++) {
			for(int k=0;k<p_group[i+1].size();k++) {
				if(p_group[i][j].dashes == p_group[i+1][k].dashes) {
					temp_number = p_group[i][j].number & p_group[i+1][k].number;
					temp_dashes = p_group[i][j].number ^ p_group[i+1][k].number;
					if(count_1s(temp_dashes)==1) {
						temp_dashes^= p_group[i][j].dashes;
						
						p_group[i][j].used = true;
						p_group[i+1][k].used = true;
						
						tmp = count_1s(temp_number);
						
						if(tmp+1>final_group.size())
							final_group.resize(tmp+1);
						
						temp_num = init_B_number(temp_number, temp_dashes, true);
						final_group[tmp].push_back(temp_num);
					}
				}
			}
		}
	}
}

/*used to avoid printing duplicates that can exist in the final table*/
bool is_printed(B_number n) {
	for(int i=0;i<printed_numbers.size();i++)
		if(n.number==printed_numbers[i].number && n.dashes == printed_numbers[i].dashes)
			return true;
	
	return false;
}
/*initialize all table*/
void init() {
	table.resize(1);
	p_group.resize(1);
	final_group.resize(1);
	create_table();
	create_p_group();
	create_final_group();
}


/*return min number of bits a number is represented by. used for best output*/
unsigned count_bits(unsigned n) {
	short bit =0;
	int count = 0;
	while(n>0) {
		bit = n%2;
		n>>=1;
		count++;
	}
	return count;
}



-(id)init
{
    if (self=[super init]) {
        self.finalArray=[[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)makeComputeWithArray:(NSMutableArray*) array{
    unsigned in;
	int num_bits=0;
	
    
	for (int i=0; i<[array count]; ++i) {
        
		
        in=[[array objectAtIndex:i] unsignedIntValue];
        input_values.push_back(in);
		num_bits = count_bits(in);	
		if(num_bits>MIN_BITS)
			MIN_BITS = num_bits;
        
    }
    init();
    int i,j;
	for(i=0;i<final_group.size();i++) {
		for(j=0;j<final_group[i].size();j++) {
			if(!is_printed(final_group[i][j])) {
                [self addBinary:final_group[i][j].number dashes:final_group[i][j].dashes];
				printed_numbers.push_back(final_group[i][j]);
			}
		}
	}
	for(i=0;i<p_group.size();i++) {
		for(j=0;j<p_group[i].size();j++) {
			if(!p_group[i][j].used) {
                [self addBinary:p_group[i][j].number dashes:p_group[i][j].dashes];
			}
		}
	}
	for(i=0;i<table.size();i++) {
		for(j=0;j<table[i].size();j++) {
			if(!table[i][j].used) {
                [self addBinary:table[i][j].number dashes:table[i][j].dashes];
			}
		}
	}
    table.clear();
    input_values.clear();
    p_group.clear();
    final_group.clear();
    printed_numbers.clear();
    
    NSLog(@"%@",finalArray);
    return finalArray;
    
}



@end
