#include "stm32f4xx.h"
#include <stdio.h>
#include "stm32f429i_discovery.h"

/* Private variables ---------------------------------------------------------*/
	void InitSortie(void)
{
	/*
	//Clock
	RCC->AHB1ENR=(RCC->AHB1ENR&0xFFFFFFDF)|(0x00000020);
	
	//GPIO G Port 13
	GPIOG->MODER=(GPIOG->MODER&0xF3FFFFFF)|(0x04000000);
	GPIOG->OTYPER=GPIOG->OTYPER;
	GPIOG->OSPEEDR=(GPIOG->OSPEEDR&0xF3FFFFFF)|(0x08000000);
	GPIOG->PUPDR=(GPIOG->PUPDR&0xF3FFFFFF)|(0x04000000);
	*/
	
	GPIO_InitTypeDef GPIO_Init1;
	
	//Clock
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOG, ENABLE);
	
	//GPIO G Port 13
	GPIO_Init1.GPIO_Pin = GPIO_Pin_13;
  GPIO_Init1.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_Init1.GPIO_PuPd = GPIO_PuPd_DOWN;
	GPIO_Init1.GPIO_OType = GPIO_OType_PP;
	GPIO_Init1.GPIO_Speed = GPIO_High_Speed;
  GPIO_Init(GPIOG, &GPIO_Init1);
	
}

void EnvoiSortie1(void)
{
	GPIOG->ODR=(GPIOG->ODR&0xFFFFDFFF)|(0x00002000);
}

void EnvoiSortie0(void)
{
	GPIOG->ODR=(GPIOG->ODR&0xFFFFDFFF);
}

void wait(int N)
{
	//CLK à 60MHz
	while(N--);
}

void waitUS(int N)
{
	wait(N*60);
}

void waitMS(int N)
{
	waitUS(N*1000);
}

void waitS(int N)
{
	waitMS(N*1000);
}

void EnvoiBit0(void)
{
	EnvoiSortie1();
	wait(24); //400ns
	EnvoiSortie0();
	wait(51); //850ns
}

void EnvoiBit1(void)
{
	EnvoiSortie1();
	wait(48); //800ns
	EnvoiSortie0();
	wait(27); //450ns
}

void EnvoiSignal(unsigned char *LED)
{
	int i=0;
	EnvoiSortie0();
	while(LED[i] != '\0'){
		if(LED[i]=='0')
		{
			EnvoiBit0();
		}
		else if(LED[i]=='1')
		{
			EnvoiBit1();
		}
		i+=1;
	}
	EnvoiSortie0();
	waitUS(50);
}
