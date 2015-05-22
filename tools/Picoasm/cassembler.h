#include <iostream>
#include <string>
#include <list>
#include <vector>
// #include <klistview.h>
#include <algorithm>
#include <cctype>

#include "types.h"
#include "cpicoblaze.h"

using namespace std ;

enum instrNumber {
	ADD, ADDCY, AND, CALL, COMPARE, DISABLE, ENABLE, FETCH, INPUT,
	JUMP, LOAD, OR, OUTPUT, RETURN, RETURNI, ROTATE, RL, RR, SL0,
	SL1, SLA, SLX, SR0, SR1, SRA, SRX, STORE, SUB, SUBCY, TEST,
	XOR 
} ;

class CNamereg {
	public:
		CNamereg() {} ;
		~CNamereg() {} ;
	
		string reg ;
		string name ;
} ;

class CConstant {
	public:
		CConstant() {}
		~CConstant() {}
	
		string value ;
		string name ;
} ;

class CLabel {
	public:
		CLabel() {}
		~CLabel() ;
	
		string value ;
		string name ;
} ;

class CSourceLine {
	public:
		enum SymbolType {
			stNone,
			stLabel,
			stNamereg,
			stConstant,
			stAddress 
		} ;
	
		CSourceLine( unsigned int lineNr ) : m_lineNr( lineNr ) 
		{ 
			m_type = stNone ; 
		} 
		~CSourceLine() {} ;

		void addColumn( string word ) 
		{ 
/*			int i ;										// Case sensitive
			for ( i = 0 ; i < word.length(); i++ ) 
				word[ i ] = toupper( word[ i ] ) ;
*/			m_line.push_back( word ) ; 
		}
		
		bool isColumn( unsigned int index ) 
		{ 
			return m_line.size() > index ; 
		}
		
		string getColumn( int index ) 
		{ 
			if ( !isColumn( index ) ) 
				return "" ; 
			else 
				return m_line[index] ; 
		}
		
		unsigned int m_lineNr; 
		vector<string> m_line ;
		unsigned int m_address ;
		SymbolType m_type ;
} ;


class CAssembler {
	public:
		CAssembler() ;
		~CAssembler() ;

		void setCode( CCode *code ) 
		{ 
			m_code = code ; 
		}
		void setFilename( string filename ) 
		{ 
			m_filename = filename ; 
		}
		bool assemble() ;
		
		void clear() { 
			m_source.clear() ; 
			m_registerTable.clear() ; 
			m_labelTable.clear() ; 
			m_constantTable.clear() ; 
		}

		// RDC 01/31/2007 - no QT for command line version
		// void setMessageList( KListView *messageList ) 
		// { 
		// 	m_messageList = messageList ; 
		// }

                // RDC 02/02/2007 add bVHDL to set VHDL or verilog file extension
		bool exportVHDL( string templateFile, string outputDir, string entityName, bool bVHDL ) ;
		// bool exportVHDL( string templateFile, string outputDir, string entityName ) ;

	protected:
		list<CSourceLine*> m_source ;
		list<CNamereg*> m_registerTable ;
		list<CConstant*> m_constantTable ;
		list<CLabel*> m_labelTable ;
		string m_filename ;
		bool buildSymbolTable() ;
		bool loadFile() ;
		
		void error( unsigned int line, const char *description ) ;
		int getRegister( string name ) ;
		
		char * getWord( char *s, char *word ) ;
		CSourceLine * formatLine( int lineNr, char *s ) ;
		
		int getInstruction( string name ) ;
		bool createOpcodes() ;
		
		string translateLabel( string name ) ;
		string translateConstant( string name ) ;
		string translateRegister( string name ) ;
		bool addInstruction( instrNumber instr, CSourceLine sourceLine, int offset ) ;
		
		CCode * m_code ;
		// KListView *m_messageList ;
} ;
