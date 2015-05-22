
#include "cinstruction.h"
#include "iostream"

using namespace std ;


CInstruction::CInstruction()
{
	m_cpu = (CPicoBlaze*) 0 ;
}

CInstruction::CInstruction( CPicoBlaze *cpu, uint32_t opcode )
{
	m_cpu = cpu ;

	sX = ( opcode & 0x0f00 ) >> 8 ;
	sY = ( opcode & 0x00f0 ) >> 4 ;
	kk = ( opcode & 0x00ff ) >> 0 ;
	pp = ( opcode & 0x00ff ) >> 0 ;
	ss = ( opcode & 0x003f ) >> 0 ;
	address = ( opcode & 0x03ff ) >> 0 ;
	
	hexcode = opcode ;
}

CInstruction::~CInstruction()
{
}

void CInstruction::Print()
{
	cout << "Unknown instruction" ;
}

void ADD_SX_KK::Execute() 
{
	uint16_t val = m_cpu->s[ sX ] + kk ;
	
	m_cpu->flags.carry = ( val > 255 ) ;
	m_cpu->flags.zero = ( val == 0 ) || ( val == 256 ) ;
	
	m_cpu->s[ sX ] = val ; 
	m_cpu->pc->Next() ;
}

void ADD_SX_KK::Print()
{
	cout << "ADD " << "s" << sX << "," << kk ;
}

void ADD_SX_SY::Execute() 
{
	uint16_t val = m_cpu->s[ sX ] + m_cpu->s[ sY ] ;
	
	m_cpu->flags.carry = ( val > 255 ) ;
	m_cpu->flags.zero = ( val == 0 ) || ( val == 256 ) ;
	
	m_cpu->s[ sX ] = val ; 
	m_cpu->pc->Next() ;
	
}

void ADD_SX_SY::Print()
{
	cout << "ADD " << "s" << sX << "," << "s" << sY ;
}

void ADDCY_SX_KK::Execute()
{
	uint16_t val = m_cpu->s[ sX ] + 1 + kk ;
	
	if ( m_cpu->flags.carry ) 
		val = m_cpu->s[ sX ] + 1 + kk ;
	else
		val = m_cpu->s[ sX ] + kk ;
	
	m_cpu->s[ sX ] = val ;
	m_cpu->flags.carry = (val > 255)  ;
	m_cpu->flags.zero = (val == 0) || (val == 256) ;
		
	m_cpu->pc->Next() ;
}

void ADDCY_SX_KK::Print()
{
	cout << "ADDCY " << "s" << sX << "," << sY ;
}

void ADDCY_SX_SY::Execute()
{
	uint16_t val ;

	if ( m_cpu->flags.carry ) 
		val = m_cpu->s[ sX ] + 1 + m_cpu->s[ sY ] ;
	else
		val = m_cpu->s[ sX ] + m_cpu->s[ sY ] ;
	
	m_cpu->s[ sX ] = val ;
	m_cpu->flags.carry = (val > 255)  ;
	m_cpu->flags.zero = (val == 0) || (val == 256) ;
		
	m_cpu->pc->Next() ;
}

void ADDCY_SX_SY::Print()
{
	cout << "ADDCY " << "s" << sX << "," << "s" << sY ;
}

void AND_SX_KK::Execute()
{

	m_cpu->s[ sX ] = m_cpu->s[ sX ] & kk ;
	m_cpu->flags.carry = 0 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;

	m_cpu->pc->Next() ;
}

void AND_SX_KK::Print()
{
	cout << "AND " << "s" << sX << "," << sY ;
}

void AND_SX_SY::Execute()
{

	m_cpu->s[ sX ] = m_cpu->s[ sX ] & m_cpu->s[ sY ] ;
	m_cpu->flags.carry = 0 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;

	m_cpu->pc->Next() ;
}

void AND_SX_SY::Print()
{
	cout << "AND " << "s" << sX << "," << "s" << sY ;
}

void CALL::Execute()
{
	m_cpu->stack->Push( ( m_cpu->pc->Get() + 1)  % 0x400 ) ;
	m_cpu->pc->Set( address ) ;
}

void CALL::Print()
{
	cout << "CALL " << address ;
}

void CALLC::Execute()
{
	if ( m_cpu->flags.carry ) {
		m_cpu->stack->Push( m_cpu->pc->Get() ) ;
		m_cpu->pc->Set( address ) ;
	} else
		m_cpu->pc->Next() ;
}

void CALLC::Print()
{
	cout << "CALL C " << address ;
}

void CALLNC::Execute()
{
	if ( !m_cpu->flags.carry ) {
		m_cpu->stack->Push( m_cpu->pc->Get() ) ;
		m_cpu->pc->Set( address ) ;
	} else
		m_cpu->pc->Next() ;
}

void CALLNC::Print()
{
	cout << "CALL NC " << address ;
}

void CALLNZ::Execute()
{
	if ( !m_cpu->flags.zero ) {
		m_cpu->stack->Push( m_cpu->pc->Get() ) ;
		m_cpu->pc->Set( address ) ;
	} else
		m_cpu->pc->Next() ;
}

void CALLNZ::Print()
{
	cout << "CALL NZ " << address ;
}

void CALLZ::Execute()
{
	if ( m_cpu->flags.zero ) {
		m_cpu->stack->Push( m_cpu->pc->Get() ) ;
		m_cpu->pc->Set( address ) ;
	} else
		m_cpu->pc->Next() ;
}

void CALLZ::Print()
{
	cout << "CALL Z " << address ;
}


void COMPARE_SX_KK::Execute()
{
	m_cpu->flags.carry = kk > m_cpu->s[ sX ] ;
	m_cpu->flags.zero = kk == m_cpu->s[ sX ] ;

	m_cpu->pc->Next() ;	
}

void COMPARE_SX_KK::Print()
{
	cout << "COMPARE s" << sX << ", "  << kk ;
}

void COMPARE_SX_SY::Execute()
{
	m_cpu->flags.carry = m_cpu->s[ sY ] > m_cpu->s[ sX ] ;
	m_cpu->flags.zero = m_cpu->s[ sY ] == m_cpu->s[ sX ] ;

	m_cpu->pc->Next() ;	
}

void COMPARE_SX_SY::Print()
{
	cout << "COMPARE s" << sX << ", s" << kk ;
}

void DISABLE_INTERRUPT::Execute()
{
	m_cpu->flags.interrupt_enable = false ;
	m_cpu->pc->Next() ;
}

void DISABLE_INTERRUPT::Print()
{
	cout << "DISABLE INTERRUPT" ;
}

void ENABLE_INTERRUPT::Execute()
{
	m_cpu->flags.interrupt_enable = true ;
	m_cpu->pc->Next() ;
}

void ENABLE_INTERRUPT::Print()
{
	cout << "ENABLE INTERRUPT" ;
}

void FETCH_SX_SS::Execute()
{
	m_cpu->s[ sX ] = m_cpu->scratch->Get( ss ) ;
	m_cpu->pc->Next() ;
}

void FETCH_SX_SS::Print()
{
	cout << "FETCH " << "s" << sX << ", " << ss ;
}

void FETCH_SX_SY::Execute()
{
	m_cpu->s[ sX ] = m_cpu->scratch->Get( m_cpu->s[ sY ] & 0x3f ) ;
	m_cpu->pc->Next() ;
	
	
}

void FETCH_SX_SY::Print() {
	cout << "FETCH " << "s" << sX << ", " << "s" << sY ;
}

void INPUT_SX_SY::Execute()
{
	m_cpu->port->PortID( m_cpu->s[ sY ] ) ;
	m_cpu->s[ sX ] = m_cpu->port->PortIn() ;
	m_cpu->pc->Next() ;
}

void INPUT_SX_SY::Print()
{
	cout << "INPUT " << "s" << sX << ", " << "s" << sY ;
}

void INPUT_SX_PP::Execute()
{
	m_cpu->port->PortID( pp ) ;
	m_cpu->s[ sX ] = m_cpu->port->PortIn() ;
	m_cpu->pc->Next() ;
}

void INPUT_SX_PP::Print()
{
	cout << "INPUT " << "s" << sX << ", " << pp ;
}

void JUMP::Execute()
{
	m_cpu->pc->Set( address ) ;
}

void JUMP::Print()
{
	cout << "JUMP " << address ;
}

void JUMPC::Execute()
{
	if ( m_cpu->flags.carry )
		m_cpu->pc->Set( address ) ;
	else
		m_cpu->pc->Next() ;
}

void JUMPC::Print()
{
	cout << "JUMP C " << address ;
}

void JUMPNC::Execute()
{
	if ( !m_cpu->flags.carry )
		m_cpu->pc->Set( address ) ;
	else
		m_cpu->pc->Next() ;
}

void JUMPNC::Print()
{
	cout << "JUMP NC " << address ;
}

void JUMPNZ::Execute()
{
	if ( !m_cpu->flags.zero )
		m_cpu->pc->Set( address ) ;
	else
		m_cpu->pc->Next() ;
}

void JUMPNZ::Print()
{
	cout << "JUMP NZ " << address ;
}

void JUMPZ::Execute()
{
	if ( m_cpu->flags.zero )
		m_cpu->pc->Set( address ) ;
	else
		m_cpu->pc->Next() ;
}

void JUMPZ::Print()
{
	cout << "JUMP Z " << address ;
}

void LOAD_SX_KK::Execute()
{
	m_cpu->s[ sX ] = kk ;
	m_cpu->pc->Next() ;
}

void LOAD_SX_KK::Print()
{
	cout << "LOAD " << "s" << sX << ", " << kk ;
}

void LOAD_SX_SY::Execute()
{
	m_cpu->s[ sX ] = m_cpu->s[ sY ] ;
	m_cpu->pc->Next() ;
}

void LOAD_SX_SY::Print()
{
	cout << "LOAD " << "s" << sX << ", " << "s" << sY ;
}

void OR_SX_KK::Execute()
{
	m_cpu->s[ sX ] = m_cpu->s[ sX ] | kk ;
	m_cpu->flags.carry = 0 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void OR_SX_KK::Print()
{
	cout << "OR " << "s" << sX << ", " << kk ;
}

void OR_SX_SY::Execute()
{
	m_cpu->s[ sX ] = m_cpu->s[ sX ] | m_cpu->s[ sY ] ;
	m_cpu->flags.carry = 0 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void OR_SX_SY::Print()
{
	cout << "OR " << "s" << sX << ", " << "s" << sY ;
}

void OUTPUT_SX_SY::Execute()
{
	m_cpu->port->PortID( m_cpu->s[ sY ] ) ;
	m_cpu->port->PortOut( m_cpu->s[ sX ] ) ;
	m_cpu->pc->Next() ;
}

void OUTPUT_SX_SY::Print()
{
	cout << "OUTPUT " << "s" << sX << ", " << "s" << sY ;
}

void OUTPUT_SX_PP::Execute()
{
	m_cpu->port->PortID( pp ) ;
	m_cpu->port->PortOut( m_cpu->s[ sX ] ) ;
	m_cpu->pc->Next() ;
}

void OUTPUT_SX_PP::Print()
{
	cout << "OUTPUT " << "s" << sX << ", " << pp ;
}

void RETURN::Execute()
{
	m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
}

void RETURN::Print()
{
	cout << "RETURN" ;
}

void RETURNC::Execute()
{
	if ( m_cpu->flags.carry )
		m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	else
		m_cpu->pc->Next() ;
}

void RETURNC::Print()
{
	cout << "RETURN C" ;
}

void RETURNNC::Execute()
{
	if ( !m_cpu->flags.carry )
		m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	else
		m_cpu->pc->Next() ;
}

void RETURNNC::Print()
{
	cout << "RETURN NC" ;
}

void RETURNNZ::Execute()
{
	if ( !m_cpu->flags.zero )
		m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	else
		m_cpu->pc->Next() ;
}

void RETURNNZ::Print()
{
	cout << "RETURN NZ" ;
}

void RETURNZ::Execute()
{
	if ( m_cpu->flags.zero )
		m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	else
		m_cpu->pc->Next() ;
}

void RETURNZ::Print()
{
	cout << "RETURN Z" ;
}

void RETURNI_DISABLE::Execute()
{
	m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	m_cpu->flags.carry = m_cpu->flags.preserved_carry ;
	m_cpu->flags.zero = m_cpu->flags.preserved_zero ;
	m_cpu->flags.interrupt_enable = false ;
}

void RETURNI_DISABLE::Print()
{
	cout << "RETURNI DISABLE" ;
}

void RETURNI_ENABLE::Execute()
{
	m_cpu->pc->Set( m_cpu->stack->Pop() ) ;
	m_cpu->flags.carry = m_cpu->flags.preserved_carry ;
	m_cpu->flags.zero = m_cpu->flags.preserved_zero ;
	m_cpu->flags.interrupt_enable = true ;
}

void RETURNI_ENABLE::Print()
{
	cout << "RETURNI ENABLE" ;
}

void RL_SX::Execute()
{
	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x80 ) != 0 ;

	m_cpu->s[ sX ] <<= 1 ;
	if ( m_cpu->flags.carry )
		m_cpu->s[ sX ] |= 1 ;

	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void RL_SX::Print()
{
	cout << "RL s" << sX ;
}

void RR_SX::Execute()
{
	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x01 ) != 0 ;

	m_cpu->s[ sX ] >>= 1 ;
	if ( m_cpu->flags.carry )
		m_cpu->s[ sX ] |= 0x80 ;

	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void RR_SX::Print()
{
	cout << "RR s" << sX ;
}


void SL0_SX::Execute()
{
	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x80 ) != 0 ;

	m_cpu->s[ sX ] <<= 1 ;

	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SL0_SX::Print()
{
	cout << "SL0 s" << sX ;
}

void SL1_SX::Execute()
{
	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x80 ) != 0 ;

	m_cpu->s[ sX ] <<= 1 ;
	m_cpu->s[ sX ] |= 1 ;

	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SL1_SX::Print()
{
	cout << "SL1 s" << sX ;
}


void SLA_SX::Execute()
{
	bool c ;

	c = m_cpu->flags.carry ;

	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x80 ) != 0 ;

	m_cpu->s[ sX ] <<= 1 ;
	if ( c )
		m_cpu->s[ sX ] |= 1 ;
	
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SLA_SX::Print()
{
	cout << "SLA s" << sX ;
}


void SLX_SX::Execute()
{
	m_cpu->flags.carry = ( m_cpu->s[ sX ] & 0x80 ) != 0 ;

	m_cpu->s[ sX ] <<= 1 ;
	if ( m_cpu->s[ sX ] & 0x02 )
		m_cpu->s[ sX ] |= 1 ;
	
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SLX_SX::Print()
{
	cout << "SLX s" << sX ;
}


void SR0_SX::Execute()
{
	m_cpu->flags.carry = m_cpu->s[ sX ] & 0x01 ;
	m_cpu->s[ sX ] >>= 1 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SR0_SX::Print()
{
	cout << "SR0 s" << sX ;
}


void SR1_SX::Execute()
{
	m_cpu->flags.carry = m_cpu->s[ sX ] & 0x01 ;
	m_cpu->s[ sX ] >>= 1 ;
	m_cpu->s[ sX ] |= 0x80 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SR1_SX::Print()
{
	cout << "SR1 s" << sX ;
}


void SRA_SX::Execute()
{
	bool c = m_cpu->flags.carry ;
	m_cpu->flags.carry = m_cpu->s[ sX ] & 0x01 ;
	m_cpu->s[ sX ] >>= 1 ;
	if ( c )
		m_cpu->s[ sX ] |= 0x80 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SRA_SX::Print()
{
	cout << "SRA s" << sX ;
}


void SRX_SX::Execute()
{
	m_cpu->flags.carry = m_cpu->s[ sX ] & 0x01 ;
	m_cpu->s[ sX ] >>= 1 ;
	if ( m_cpu->s[ sX ] & 0x40  )
		m_cpu->s[ sX ] |= 0x80 ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void SRX_SX::Print()
{
	cout << "SRX s" << sX ;
}


void STORE_SX_SS::Execute()
{
	m_cpu->scratch->Set( ss, m_cpu->s[ sX ] ) ;
	m_cpu->pc->Next() ;

}

void STORE_SX_SS::Print()
{
	cout << "STORE s" << sX << ", " << ss ;
}


void STORE_SX_SY::Execute()
{
	m_cpu->scratch->Set( m_cpu->s[ sY ], m_cpu->s[ sX ] ) ;
	m_cpu->pc->Next() ;
}

void STORE_SX_SY::Print()
{
	cout << "STORE s" << sX << ", s" << sY ;
}

void SUB_SX_KK::Execute()
{
	int val ;
	
	val = m_cpu->s[ sX ] ;
	val -= kk ;

	m_cpu->flags.carry = val < 0 ;
	m_cpu->flags.zero = val == 0 ;
	
	m_cpu->s[ sX ] -= kk ;

	m_cpu->pc->Next() ;
}

void SUB_SX_KK::Print()
{
	cout << "SUB s" << sX << ", " << kk ;
}

void SUB_SX_SY::Execute()
{
	int val ;
	
	val = m_cpu->s[ sX ] ;
	val -= m_cpu->s[ sY ] ;

	m_cpu->flags.carry = val < 0 ;
	m_cpu->flags.zero = val == 0 ;
	
	m_cpu->s[ sX ] -= m_cpu->s[ sY ] ;

	m_cpu->pc->Next() ;
}

void SUB_SX_SY::Print()
{
	cout << "SUB s" << sX << ", s" << sY ;
}


void SUBCY_SX_KK::Execute()
{
	int val ;
	bool c = m_cpu->flags.carry ;	
	val = m_cpu->s[ sX ] ;
	val -= kk ;
	if ( c )
		val -= 1 ;

	m_cpu->flags.carry = val < 0 ;
	m_cpu->flags.zero = val == 0 ;
	m_cpu->s[ sX ] -= kk ;
	if ( c )
		c -= 1 ;

	m_cpu->pc->Next() ;
}

void SUBCY_SX_KK::Print()
{
	cout << "SUBCY s" << sX << ", " << kk ;
}

void SUBCY_SX_SY::Execute()
{
	int val ;
	bool c = m_cpu->flags.carry ;	
	val = m_cpu->s[ sX ] ;
	val -= m_cpu->s[ sY ] ;
	if ( c )
		val -= 1 ;

	m_cpu->flags.carry = val < 0 ;
	m_cpu->flags.zero = val == 0 ;
	m_cpu->s[ sX ] -= kk ;
	if ( c )
		c -= 1 ;

	m_cpu->pc->Next() ;
}

void SUBCY_SX_SY::Print()
{
	cout << "SUBCY s" << sX << ", s" << sY ;
}

void TEST_SX_KK::Execute()
{
	uint8_t and_test = ( m_cpu->s[ sX ] & kk ) ;
	m_cpu->flags.zero = and_test == 0 ;

	int i ;

	uint8_t xor_test = 0, b ;

	for ( i = 0 ; i < 8 ; i++ ) {
		b = ( and_test & ( 1 << i ) ) != 0 ; 
		xor_test = b ^ xor_test ;	
	}

	m_cpu->flags.carry = xor_test != 0 ;
	m_cpu->pc->Next() ;
}

void TEST_SX_KK::Print()
{
	cout << "TEST s" << sX << ", " << kk ;
}

void TEST_SX_SY::Execute()
{
	uint8_t and_test = ( m_cpu->s[ sX ] & m_cpu->s[ sY ] ) ;
	m_cpu->flags.zero = and_test == 0 ;

	int i ;

	uint8_t xor_test = 0, b ;

	for ( i = 0 ; i < 8 ; i++ ) {
		b = ( and_test & ( 1 << i ) ) != 0 ; 
		xor_test = b ^ xor_test ;	
	}

	m_cpu->flags.carry = xor_test != 0 ;
	m_cpu->pc->Next() ;
}

void TEST_SX_SY::Print()
{
	cout << "TEST s" << sX << ", s" << sY ;
}

void XOR_SX_KK::Execute()
{
	m_cpu->s[ sX ] ^= kk ;
	
	m_cpu->flags.carry = false ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void XOR_SX_KK::Print()
{
	cout << "XOR s" << sX << ", " << kk ;
}


void XOR_SX_SY::Execute()
{
	m_cpu->s[ sX ] ^= m_cpu->s[ sY ] ;
	
	m_cpu->flags.carry = false ;
	m_cpu->flags.zero = m_cpu->s[ sX ] == 0 ;
	m_cpu->pc->Next() ;
}

void XOR_SX_SY::Print()
{
	cout << "XOR s" << sX << ", s" << sY ;
}

void RESET_EVENT::Execute() 
{
	m_cpu->pc->Set( 0 ) ;
	m_cpu->flags.interrupt_enable = false ;
	m_cpu->flags.zero = false ;
	m_cpu->flags.carry = false ;
	m_cpu->stack->Reset() ;
} 

void RESET_EVENT::Print()
{
	cout << "(RESET EVENT)" ;
}

void INTERRUPT_EVENT::Execute()
{
	if ( m_cpu->flags.interrupt_enable ) {
		m_cpu->flags.interrupt_enable = false ;
		m_cpu->stack->Push( m_cpu->pc->Get() ) ;
		m_cpu->flags.preserved_carry = m_cpu->flags.carry ;
		m_cpu->flags.preserved_zero = m_cpu->flags.zero ;
		m_cpu->pc->Set( 0x3FF ) ;	
	}
}

void INTERRUPT_EVENT::Print()
{
	cout << "(INTERRUPT EVENT)" ;
}

