#include "cpicoblaze.h"

#include <iostream>

using namespace std ;

CProgramCounter::CProgramCounter()
{
	pc = 0 ;
}

CProgramCounter::~CProgramCounter()
{

}

void CProgramCounter::Next()
{
	pc = ( pc + 1 ) % (MAX_ADDRESS);
}

void CProgramCounter::Set( uint16_t address )
{
	pc = address % (MAX_ADDRESS) ;
}

uint16_t CProgramCounter::Get()
{
	return pc ;
}

CScratchPad::CScratchPad()
{
	int i ;
	for ( i = 0 ; i < sizeof( ram ) ; i++ )
		ram[ i ] = 0 ;
}

CScratchPad::~CScratchPad()
{
}

CStack::CStack()
{
	int i ;
	for ( i = 0 ; i < STACK_DEPTH ; i++ )
		stack[ i ] = 0 ;
	ptr = 0 ;
}

CStack::~CStack()
{
}

void CStack::Push( uint16_t data )
{	
	data &= 0x3FF ;
	if ( ptr == STACK_DEPTH - 1 )
	  cout << ">>>>Stack overflow!<<<<" << endl ;
		
	stack[ ptr ] = data ;
	ptr = ( ptr + 1 ) % STACK_DEPTH ;
}

uint16_t CStack::Pop()
{
	if ( ptr == 0 )
	  cout << ">>>>Stack underflow!<<<<" << endl ;
		
	ptr = ( ptr - 1 ) % STACK_DEPTH ;
	return stack[ ptr ] ;
}

void CStack::Reset()
{
	ptr = 0 ;
}

uint8_t CScratchPad::Get( uint8_t address )
{
	return ram[ address % sizeof( ram ) ] ;
}

void CScratchPad::Set( uint8_t address, uint8_t data )
{
	ram[ address % sizeof( ram ) ] = data ;
}

CPort::CPort()
{
}


CPort::~CPort()
{
}

void CPort::addPort( CIOPort * port )
{
	portList.push_back( port ) ;
}

void CPort::deletePort( CIOPort * port )
{
	portList.remove( port ) ;
}

uint8_t CPort::PortIn()
{
	// find appropiate port 
	list<CIOPort*>::iterator i ;
	
	for ( i = portList.begin() ; i != portList.end() ; i++ ) 
		if ( (*i)->getID() == portid && (*i)->isReadable() )
			return (*i)->In() ;
	
	
	// Nothing found return zero
	return 0 ;
}

void CPort::PortOut( uint8_t data )
{
	// find appropiate port 
	list<CIOPort*>::iterator i ;
	
	for ( i = portList.begin() ; i != portList.end() ; i++ ) 
		if ( (*i)->getID() == portid && (*i)->isWriteable() )
			(*i)->Out( data ) ;
}


CCode::CCode( CPicoBlaze *cpu ) 
{
	m_cpu = cpu ;
	
	int i ;
	for ( i = 0 ; i < MAX_ADDRESS ; i++ )
		CodeMap[ i ] = NULL ;
}

CCode::~CCode()
{
	ClearCode() ;
}

void CCode::ClearCode() {	
	int i ;
	for ( i = 0 ; i < MAX_ADDRESS ; i++ )
		if ( CodeMap[ i ] != NULL ) {
			delete CodeMap[ i ] ;
			CodeMap[ i ] = NULL ;
		}
}

CInstruction * CCode::Disassemble( uint32_t code )
{
	uint32_t code_17_0  = (code & 0x3ffff) ;
	uint32_t code_17_12 = (code & 0x3f000) ;
	uint32_t code_17_10 = (code & 0x3fC00) ;
	uint32_t code_7_0   = (code & 0x000ff) ;

	switch( code_17_0 ) {
	case instrRETURN            : return new RETURN( m_cpu, code ) ;
	case instrRETURNC           : return new RETURNC( m_cpu, code ) ;
	case instrRETURNNC          : return new RETURNNC( m_cpu, code ) ;
	case instrRETURNNZ          : return new RETURNNZ( m_cpu, code ) ;
	case instrRETURNZ           : return new RETURNZ( m_cpu, code ) ;
	case instrRETURNI_DISABLE   : return new RETURNI_DISABLE( m_cpu, code ) ;
	case instrRETURNI_ENABLE    : return new RETURNI_ENABLE( m_cpu, code ) ;
	case instrDISABLE_INTERRUPT : return new DISABLE_INTERRUPT( m_cpu, code ) ;
	case instrENABLE_INTERRUPT  : return new ENABLE_INTERRUPT( m_cpu, code ) ;
	default:
		switch( code_17_10 ) {
		case instrCALL   : return new CALL( m_cpu, code ) ;
		case instrCALLC  : return new CALLC( m_cpu, code ) ;
		case instrCALLNC : return new CALLNC( m_cpu, code ) ;
		case instrCALLNZ : return new CALLNZ( m_cpu, code ) ;
		case instrCALLZ  : return new CALLZ( m_cpu, code ) ;
		case instrJUMP   : return new JUMP( m_cpu, code ) ;
		case instrJUMPC  : return new JUMPC( m_cpu, code ) ;
		case instrJUMPNC : return new JUMPNC( m_cpu, code ) ;
		case instrJUMPNZ : return new JUMPNZ( m_cpu, code ) ;
		case instrJUMPZ  : return new JUMPZ( m_cpu, code ) ;
		default:
			switch ( code_17_12 ) {
			case instrADD_SX_KK     : return new ADD_SX_KK( m_cpu, code ) ;
			case instrADD_SX_SY     : return new ADD_SX_SY( m_cpu, code ) ;
			case instrADDCY_SX_KK   : return new ADDCY_SX_KK( m_cpu, code ) ;
			case instrADDCY_SX_SY   : return new ADDCY_SX_SY( m_cpu, code ) ;
			case instrAND_SX_KK     : return new AND_SX_KK( m_cpu, code ) ;
			case instrAND_SX_SY     : return new AND_SX_SY( m_cpu, code ) ;
			case instrCOMPARE_SX_KK : return new COMPARE_SX_KK( m_cpu, code ) ;
			case instrCOMPARE_SX_SY : return new COMPARE_SX_SY( m_cpu, code ) ;
			case instrFETCH_SX_SS   : return new FETCH_SX_SS( m_cpu, code ) ;
			case instrFETCH_SX_SY   : return new FETCH_SX_SY( m_cpu, code ) ;
			case instrINPUT_SX_SY   : return new INPUT_SX_SY( m_cpu, code ) ;
			case instrINPUT_SX_PP   : return new INPUT_SX_PP( m_cpu, code ) ;
			case instrLOAD_SX_KK    : return new LOAD_SX_KK( m_cpu, code ) ;
			case instrLOAD_SX_SY    : return new LOAD_SX_SY( m_cpu, code ) ;
			case instrOR_SX_KK      : return new OR_SX_KK( m_cpu, code ) ;
			case instrOR_SX_SY      : return new OR_SX_SY( m_cpu, code ) ;
			case instrOUTPUT_SX_SY  : return new OUTPUT_SX_SY( m_cpu, code ) ;
			case instrOUTPUT_SX_PP  : return new OUTPUT_SX_PP( m_cpu, code ) ;
			case instrSTORE_SX_SS   : return new STORE_SX_SS( m_cpu, code ) ;	  
			case instrSTORE_SX_SY   : return new STORE_SX_SY( m_cpu, code ) ;	  
			case instrSUB_SX_KK     : return new SUB_SX_KK( m_cpu, code ) ;	  
			case instrSUB_SX_SY     : return new SUB_SX_SY( m_cpu, code ) ;	  
			case instrSUBCY_SX_KK   : return new SUBCY_SX_KK( m_cpu, code ) ;	  
			case instrSUBCY_SX_SY   : return new SUBCY_SX_SY( m_cpu, code ) ;	  
			case instrTEST_SX_KK    : return new TEST_SX_KK( m_cpu, code ) ;	  
			case instrTEST_SX_SY    : return new TEST_SX_SY( m_cpu, code ) ;	  
			case instrXOR_SX_KK		: return new XOR_SX_KK( m_cpu, code ) ;
			case instrXOR_SX_SY		: return new XOR_SX_SY( m_cpu, code ) ;
			
			case instrROTATE:
				switch( code_7_0 ) {
				case instrRL_SX  : return new RL_SX( m_cpu, code ) ;
				case instrRR_SX  : return new RR_SX( m_cpu, code ) ;
				case instrSL0_SX : return new SL0_SX( m_cpu, code ) ;
				case instrSL1_SX : return new SL1_SX( m_cpu, code ) ;
				case instrSLA_SX : return new SLA_SX( m_cpu, code ) ;
				case instrSLX_SX : return new SLX_SX( m_cpu, code ) ;
				case instrSR0_SX : return new SR0_SX( m_cpu, code ) ;
				case instrSR1_SX : return new SR1_SX( m_cpu, code ) ;
				case instrSRA_SX : return new SRA_SX( m_cpu, code ) ;
				case instrSRX_SX : return new SRX_SX( m_cpu, code ) ;
				}
			}
		}
	}

	cout << "Invalid code (" << code << endl ;
	
	return NULL ;
}

bool CCode::setInstruction( uint16_t address, uint32_t code, unsigned int sourceLine )
{
	CInstruction *instr = Disassemble( code ) ;
	if ( instr == NULL ) {
	  cout << ">>>>Unknown code at address " << address << "<<<<" << endl ;
		return FALSE ;
	}
	
	if ( address >= MAX_ADDRESS ) {
	  cout << ">>>>Invalid address" << address << "<<<<" << endl ;
		delete instr ;
		return FALSE ;
	}
	
	
	if ( CodeMap[ address ] != NULL ) {
	  cout << ">>>>Code is placed at same address (" << address << ")<<<<" << endl ;
		delete instr ;
		return FALSE ;
	}
	
	instr->setSourceLine( sourceLine ) ;
	CodeMap[ address ] = instr ;
	
	return TRUE ;
}

CInstruction * CCode::getInstruction( uint16_t address )
{
	if ( address >= MAX_ADDRESS )
		return NULL ;
	else
		return CodeMap[ address ] ;
}

void CCode::Print()
{
	int i ;
	
	cout << "----listing----" << endl ;
	for ( i = 0 ; i < MAX_ADDRESS ;  i++ ) {
		if ( CodeMap[ i ] != NULL ) {
			cout << i << "  : " ;
			CodeMap[ i ]->Print() ;
			cout << endl ;
		}
	}
	cout << "----end listing----" << endl ;

}

CPicoBlaze::CPicoBlaze()
{
	flags.zero = false ;
	flags.carry = false ;
	flags.interrupt_enable = false ;

	scratch = new CScratchPad ;
	pc = new CProgramCounter ;
	stack = new CStack ;
	port = new CPort ;
	code = new CCode( this ) ;
}

CPicoBlaze::~CPicoBlaze()
{
	delete scratch ;
	delete pc ;
	delete stack ;
	delete port ;
	delete code ;
}

void CPicoBlaze::Reset()
{
	RESET_EVENT resetEvent( this, 0 ) ;
	
	resetEvent.Print() ; cout << endl ;
	resetEvent.Execute() ;
}

void CPicoBlaze::Interrupt()
{
	INTERRUPT_EVENT interruptEvent( this, 0 ) ;
	
	interruptEvent.Print() ; cout << endl ;
	interruptEvent.Execute() ;
}

void CPicoBlaze::Print()
{
	int i ;
	
	cout << "----CPU----" << endl ;
	cout << "regs|" ;
	for ( i = 0 ; i < 15 ; i++ ) 
		cout << "s" << i << "=" << (int) s[ i ]  << "|" ;
	cout << endl ;
	
	cout << "flags|";
	cout << "c=" << flags.carry ;
	cout << "|z=" << flags.zero ;
	cout << "|ie=" << flags.interrupt_enable << "|" << endl ;
	cout << "----end CPU----" << endl ;
}

unsigned int CPicoBlaze::GetNextSourceLine()
{
	CInstruction *instr = code->getInstruction( pc->Get() ) ;
	if ( instr == NULL ) {
	  cout << ">>>>Error in simulation (No code found at " << pc->Get() << ")<<<<" << endl ;
		return FALSE ;
	}

	return instr->getSourceLine() ;
}

bool CPicoBlaze::Next()
{
	CInstruction *instr = code->getInstruction( pc->Get() ) ;
	if ( instr == NULL ) {
	  cout << ">>>>Error in simulation (No code found at " << pc->Get() << ")<<<<" << endl ;
		return FALSE ;
	}

	instr->Execute() ;
		
	return TRUE ;
}

void CPicoBlaze::addPort( CIOPort * ioport )
{
	port->addPort( ioport ) ; 
}

void CPicoBlaze::deletePort( CIOPort * ioport )
{
	port->deletePort( ioport ) ;
}


