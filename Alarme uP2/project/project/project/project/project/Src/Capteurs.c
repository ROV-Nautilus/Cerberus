#include "stm32f4xx.h"
#include <stdio.h>
#include "stm32f429i_discovery.h"

void InitCapteur(){
	GPIO_InitTypeDef GPIO_Init2;
	GPIO_InitTypeDef GPIO_Init3;
	GPIO_InitTypeDef GPIO_Init4;
	
	//GPIO G Port 14
	GPIO_Init2.Pin = GPIO_PIN_14;
  GPIO_Init2.Mode = GPIO_MODE_INPUT;
  GPIO_Init2.Pull = GPIO_NOPULL;
	GPIO_Init2.Speed = GPIO_SPEED_HIGH;
	HAL_GPIO_Init(GPIOG, &GPIO_Init2);
	
	//GPIO D Port 11
	GPIO_Init3.Pin = GPIO_PIN_11;
  GPIO_Init3.Mode = GPIO_MODE_INPUT;
  GPIO_Init3.Pull = GPIO_NOPULL;
	GPIO_Init3.Speed = GPIO_SPEED_HIGH;
	HAL_GPIO_Init(GPIOD, &GPIO_Init3);
	
	//GPIO B Port 13
	GPIO_Init4.Pin = GPIO_PIN_13;
  GPIO_Init4.Mode = GPIO_MODE_INPUT;
  GPIO_Init4.Pull = GPIO_NOPULL;
	GPIO_Init4.Speed = GPIO_SPEED_HIGH;
	HAL_GPIO_Init(GPIOB, &GPIO_Init4);
}

uint8_t Capteur1(){
	return HAL_GPIO_ReadPin(GPIOG, GPIO_PIN_14);
}

uint8_t Capteur2(){
	return HAL_GPIO_ReadPin(GPIOD, GPIO_PIN_11);
}

uint8_t Capteur3(){
	return HAL_GPIO_ReadPin(GPIOB, GPIO_PIN_13);
}
