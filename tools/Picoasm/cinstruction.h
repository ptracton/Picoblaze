
#ifndef CINSTRUCTION
#define CINSTRUCTION

#include "types.h"
#include "cpicoblaze.h"

//class CPicoBlaze ;

// CInstruction members : 
// 	adress = Absolute instruction address
// 	sX = Register sX
// 	sY = Register sY
// 	kk = Immediate constant
// 	pp = port
// 	ss = Scratchpad RAM address

class CInstruction {

	public:
		CInstruction() ;
		CInstruction( CPicoBlaze *cpu, uint32_t opcode ) ;
		virtual ~CInstruction() ;

		virtual void Execute() = 0 ;
		virtual void Print() ;

		void setSourceLine( unsigned int line ) { sourceLine = line ; }
		unsigned int getSourceLine() { return sourceLine ; }
		
		uint32_t getHexCode() { return hexcode ; }
	protected:
		CPicoBlaze *m_cpu ;

		uint16_t sX, sY, ss, pp, kk, address ;
		uint32_t hexcode ;
		unsigned int sourceLine ;
} ;


class ADD_SX_KK : public CInstruction {

	public:
		ADD_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
		
} ;

class ADD_SX_SY : public CInstruction {

	public:
		ADD_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class ADDCY_SX_KK : public CInstruction {

	public:
		ADDCY_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class ADDCY_SX_SY : public CInstruction {

	public:
		ADDCY_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class AND_SX_KK : public CInstruction {

	public:
		AND_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class AND_SX_SY : public CInstruction {

	public:
		AND_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class CALL : public CInstruction {

	public:
		CALL( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class CALLC : public CInstruction {

	public:
		CALLC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class CALLNC : public CInstruction {

	public:
		CALLNC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class CALLNZ : public CInstruction {

	public:
		CALLNZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class CALLZ : public CInstruction {

	public:
		CALLZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class COMPARE_SX_KK : public CInstruction {

	public:
		COMPARE_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class COMPARE_SX_SY : public CInstruction {

	public:
		COMPARE_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class DISABLE_INTERRUPT : public CInstruction {

	public:
		DISABLE_INTERRUPT( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class ENABLE_INTERRUPT : public CInstruction {

	public:
		ENABLE_INTERRUPT( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class FETCH_SX_SS : public CInstruction {

	public:
		FETCH_SX_SS( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class FETCH_SX_SY : public CInstruction {

	public:
		FETCH_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class INPUT_SX_SY : public CInstruction {

	public:
		INPUT_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class INPUT_SX_PP : public CInstruction {

	public:
		INPUT_SX_PP( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class JUMP : public CInstruction {

	public:
		JUMP( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class JUMPC : public CInstruction {

	public:
		JUMPC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class JUMPNC : public CInstruction {

	public:
		JUMPNC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class JUMPNZ : public CInstruction {

	public:
		JUMPNZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class JUMPZ : public CInstruction {

	public:
		JUMPZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class LOAD_SX_KK : public CInstruction {

	public:
		LOAD_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class LOAD_SX_SY : public CInstruction {

	public:
		LOAD_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class OR_SX_KK : public CInstruction {

	public:
		OR_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class OR_SX_SY : public CInstruction {

	public:
		OR_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class OUTPUT_SX_SY : public CInstruction {

	public:
		OUTPUT_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class OUTPUT_SX_PP : public CInstruction {

	public:
		OUTPUT_SX_PP( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class RETURN : public CInstruction {

	public:
		RETURN( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNC : public CInstruction {

	public:
		RETURNC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNNC : public CInstruction {

	public:
		RETURNNC( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNNZ : public CInstruction {

	public:
		RETURNNZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNZ : public CInstruction {

	public:
		RETURNZ( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNI_DISABLE : public CInstruction {

	public:
		RETURNI_DISABLE( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RETURNI_ENABLE : public CInstruction {

	public:
		RETURNI_ENABLE( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RL_SX : public CInstruction {

	public:
		RL_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class RR_SX : public CInstruction {

	public:
		RR_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SL0_SX : public CInstruction {

	public:
		SL0_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SL1_SX : public CInstruction {

	public:
		SL1_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SLA_SX : public CInstruction {

	public:
		SLA_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SLX_SX : public CInstruction {

	public:
		SLX_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SR0_SX : public CInstruction {

	public:
		SR0_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SR1_SX : public CInstruction {

	public:
		SR1_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SRA_SX : public CInstruction {

	public:
		SRA_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SRX_SX : public CInstruction {

	public:
		SRX_SX( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class STORE_SX_SS : public CInstruction {

	public:
		STORE_SX_SS( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ; 

		void Execute() ;
		void Print() ;

} ;

class STORE_SX_SY : public CInstruction {

	public:
		STORE_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SUB_SX_KK : public CInstruction {

	public:
		SUB_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SUB_SX_SY : public CInstruction {

	public:
		SUB_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class SUBCY_SX_KK : public CInstruction {

	public:
		SUBCY_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class SUBCY_SX_SY : public CInstruction {

	public:
		SUBCY_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class TEST_SX_KK : public CInstruction {

	public:
		TEST_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class TEST_SX_SY : public CInstruction {

	public:
		TEST_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class XOR_SX_KK : public CInstruction {

	public:
		XOR_SX_KK( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;

} ;

class XOR_SX_SY : public CInstruction {

	public: 
		XOR_SX_SY( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class RESET_EVENT : public CInstruction {

	public: 
		RESET_EVENT( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

class INTERRUPT_EVENT : public CInstruction {

	public: 
		INTERRUPT_EVENT( CPicoBlaze *cpu, uint32_t opcode ) : CInstruction( cpu, opcode ) {} ;

		void Execute() ;
		void Print() ;
} ;

#endif

