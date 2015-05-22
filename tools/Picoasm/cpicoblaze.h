
#ifndef CPICOBLAZE
#define CPICOBLAZE

#include <iostream>
#include <list>

using namespace std ;

class CPicoBlaze ;
class CInstruction ;

#include "types.h"
#include "cinstruction.h"
#include "hexcodes.h"

#define MAX_ADDRESS		0x400
#define STACK_DEPTH		31
#define SCRATCHPAD_SIZE	64

#define PortReadable 1
#define PortWriteable 2
class CIOPort
{
	public:
	
		CIOPort( uint8_t id )  { m_id = id ; m_mode = 0 ; }
		
		virtual void Out( uint8_t val ) = 0 ;
		virtual uint8_t In() = 0 ;
	
		uint8_t getID() { return m_id ; }
		void setID( uint8_t id ) { m_id = id ; }
		void setMode( int mode ) { m_mode = mode ; }
		int getMode() { return m_mode ; }
		bool isReadable() { return (m_mode & PortReadable) != 0 ; }
		bool isWriteable() { return (m_mode & PortWriteable) != 0 ; }

	private:
		uint8_t m_id ;
		int m_mode ;
} ;

class CProgramCounter {
	public:
		CProgramCounter() ;
 		~CProgramCounter() ;
		
		void Next() ;
		void Set( uint16_t address ) ;
		uint16_t Get() ;

	protected:
		uint16_t pc ;
} ;

class CScratchPad {
	public:
		CScratchPad() ;
		~CScratchPad() ;

		uint8_t Get( uint8_t address ) ;
		void Set( uint8_t address, uint8_t data ) ;

	protected:
		uint8_t ram[ SCRATCHPAD_SIZE ] ;
} ;

class CStack {
	public:
		CStack() ;
		~CStack() ;

		void Push( uint16_t value ) ;
		uint16_t Pop() ;
		void Reset() ;

	protected:
		uint16_t stack[ STACK_DEPTH ] ;
		uint8_t ptr ;
} ;

class CPort {
	public:
		CPort() ;
		~CPort() ;

		void PortID( uint8_t id ) { portid = id ; } ;
		uint8_t PortIn() ;
		void PortOut( uint8_t data ) ;
	
		void addPort( CIOPort * port ) ;
		void deletePort( CIOPort * port ) ;
		
	protected:
		uint16_t portid ;

		list<CIOPort*> portList ;
	
} ;

class CCode {
	public:
		CCode( CPicoBlaze *cpu ) ;
		~CCode() ;

		bool setInstruction( uint16_t address, uint32_t code, unsigned int sourceLine  ) ;
		CInstruction *getInstruction( uint16_t address ) ;
	
		void ClearCode() ;
		void Print() ;	
			
		CInstruction * Disassemble( uint32_t code ) ;
	
	protected:
		CPicoBlaze *m_cpu ;
		
		CInstruction * CodeMap[ MAX_ADDRESS ] ;
} ;

class CPicoBlaze {
		
	public:		
		CPicoBlaze() ;
		~CPicoBlaze() ;
	
		unsigned int GetNextSourceLine() ;
		bool Next() ;
		void Reset() ;
		void Interrupt() ;
		void Print() ;
				
		void addPort( CIOPort * ioport ) ;
		void deletePort( CIOPort * ioport ) ;
		
		uint8_t s[ 16 ] ;
		struct _flags {
			bool zero ;
			bool carry ;
			bool interrupt_enable ;

			bool preserved_zero ;
			bool preserved_carry ;
		} flags ;

		CProgramCounter	*pc ;
		CScratchPad 	*scratch ;
		CStack 			*stack ;
		CPort			*port ;
		CCode			*code ;
} ;

#endif

