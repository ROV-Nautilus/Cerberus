#include "stm32f4xx.h"
#include "LEDs.h"
#include <stdio.h>
#include "stm32f429i_discovery.h"

/* Private variables ---------------------------------------------------------*/
	void InitSortie(void)
{
	GPIO_InitTypeDef GPIO_Init1;
	
	//Clock
	__HAL_RCC_GPIOG_CLK_ENABLE();
	
	//GPIO G Port 13
	GPIO_Init1.Pin = GPIO_PIN_13;
  GPIO_Init1.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_Init1.Pull = GPIO_PULLDOWN;
	GPIO_Init1.Speed = GPIO_SPEED_HIGH;
	HAL_GPIO_Init(GPIOG, &GPIO_Init1);
	
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
