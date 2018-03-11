/**
  ******************************************************************************
  * @file    STemWin/STemWin_SampleDemo/Src/main.c
  * @author  MCD Application Team
  * @version V1.3.5
  * @date    03-June-2016
  * @brief   This file provides main program functions
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright © 2016 STMicroelectronics International N.V. 
  * All rights reserved.</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "rtc.h"
#include "GUIDEMO.h"
#include "WM.h"
#include "PremierMenu.h"
#include "Marche.h"
#include "Digicode.h"
#include "Code1.h"
#include "Code2.h"
#include "Code3.h"
#include "Code4.h"
#include "Bloque.h"
#include "LEDs.h"
#include "Capteurs.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
DAC_HandleTypeDef    DacHandle;
DAC_ChannelConfTypeDef sConfig;
DAC_ChannelConfTypeDef sConfig2;

const uint8_t Sine8bit[32] = {127, 152, 176, 198, 217, 233, 245, 252, 255,
																		252, 245, 233, 217, 198, 176, 152, 127, 102,
																		78, 56, 37, 21, 9, 2, 0, 2, 9, 21, 37, 56, 78, 102};


static void TIM6_Config(int f);
static void DAC_Ch2_SineWaveConfig(void);
static void Error_Handler(void);
static void AllumerSon(void);
static void EteindreSon(void);

uint8_t GUI_Initialized = 0;

TIM_HandleTypeDef    TimHandle;
uint32_t uwPrescalerValue = 0;

/* Private function prototypes -----------------------------------------------*/
static void BSP_Config(void);
static void SystemClock_Config(void);
void BSP_Pointer_Update(void);
void BSP_Background(void);

extern void MainTask(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
int main(void)
{  
	int i = 0;
	
	int Cap1 = 0;
	int Cap2 = 0;
	int Cap3 = 0;
	int f = 0x301A;
	
	int Code = 1234;
	int CodeTaper = 0;
	int j = 0;
	
	uint8_t C1;
	uint8_t C2;
	uint8_t C3;
	static TS_StateTypeDef TP_State;
  /* STM32F4xx HAL library initialization:
       - Configure the Flash prefetch, instruction and Data caches
       - Configure the Systick to generate an interrupt each 1 msec
       - Set NVIC Group Priority to 4
       - Global MSP (MCU Support Package) initialization
     */
  HAL_Init();  
  
  /* Initialize LCD and LEDs */
  BSP_Config();
  
  /* Configure the system clock to 180 MHz */
  SystemClock_Config();
  
  /***********************************************************/
  
   /* Compute the prescaler value to have TIM3 counter clock equal to 10 KHz */
  uwPrescalerValue = (uint32_t) ((SystemCoreClock /2) / 10000) - 1;
  
  /* Set TIMx instance */
  TimHandle.Instance = TIM3;
   
  /* Initialize TIM3 peripheral as follows:
       + Period = 500 - 1
       + Prescaler = ((SystemCoreClock/2)/10000) - 1
       + ClockDivision = 0
       + Counter direction = Up
  */
  TimHandle.Init.Period = 500 - 1;
  TimHandle.Init.Prescaler = uwPrescalerValue;
  TimHandle.Init.ClockDivision = 0;
  TimHandle.Init.CounterMode = TIM_COUNTERMODE_UP;
  if(HAL_TIM_Base_Init(&TimHandle) != HAL_OK)
  {
    while(1) 
    {
    }
  }
  
  /*##-2- Start the TIM Base generation in interrupt mode ####################*/
  /* Start Channel1 */
	
	
  if(HAL_TIM_Base_Start_IT(&TimHandle) != HAL_OK)
  {
    while(1) 
    {
    }
  }
  
  /***********************************************************/
  
  /* Init the STemWin GUI Library */
  GUI_Init();
  GUI_Initialized = 1;
  
  /* Initialize RTC and Backup */
  RTC_Init();
  
  /* Activate the use of memory device feature */
  WM_SetCreateFlags(WM_CF_MEMDEV);
	
	/* Do the calibration if needed */
  //CALIBRATION_Check();
	/* Start Demo */
  //GUIDEMO_Main();
  
	//Affichage du premiermenu
	CreatePremierMenu();
	
	/*Initialisation Sortie */
	InitSortie();
	EnvoiSortie0();
	
	/*##-1- Configure the DAC peripheral #######################################*/
  DacHandle.Instance = DAC;
	
  
	EnvoiSignal((unsigned char*)"000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000");
	
  while(1) 
  {
		GUI_Exec();
		BSP_TS_GetState(&TP_State);
		if(i==0)
		{
			//Bouton On
			if ((TP_State.TouchDetected) && (TP_State.Y <= 200) && (TP_State.Y >= 130) && (TP_State.X >= 30) && (TP_State.X <= 100))
			{
				i++;
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
				CreateMarche();
				waitMS(250);
			}
			//Bouton Off
			else if ((TP_State.TouchDetected) && (TP_State.Y <= 200) && (TP_State.Y >= 130) && (TP_State.X >= 140) && (TP_State.X <= 210))
			{
				//Eteindre Appareil
			}
			else
			{
			}
		}
		else if(i==1)
		{
			if(f>0x1F00)
			{
				f=0x101A;
			}
			f=f+0xA;
			
			
			//Recuperation des valeurs des capteurs
			C1 = Capteur1();
			C2 = Capteur2();
			C3 = Capteur3();
			
			//Vert
			if(Cap1==0 && Cap2==0 && Cap3==0){
			EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
			}
			
			//Bouton On
			if ((TP_State.TouchDetected) && (TP_State.Y <= 200) && (TP_State.Y >= 130) && (TP_State.X >= 30) && (TP_State.X <= 100))
			{
			}
			//Bouton Off
			else if ((TP_State.TouchDetected) && (TP_State.Y <= 200) && (TP_State.Y >= 130) && (TP_State.X >= 140) && (TP_State.X <= 210))
			{
				i++;
				waitMS(250);
				f=0x101A;
				CreateDigicode();
			}
			//Capteur1
			if(Cap1==1 && Cap2==0 && Cap3==0){
				//EnvoiSignal
				TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
			}
			if(Cap1==0 && Cap2==1 && Cap3==0){
				//EnvoiSignal
				TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000");
			}
			if(Cap1==0 && Cap2==0 && Cap3==1){
				//EnvoiSignal
				TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000");
			}
			if(Cap1==0 && Cap2==1 && Cap3==1){
				//EnvoiSignal
				TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000");
			}
			if(Cap1==1 && Cap2==0 && Cap3==1){
				//EnvoiSignal
			  TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000");
				}
			if(Cap1==1 && Cap2==1 && Cap3==0){
				//EnvoiSignal
			  TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000");
			  }
			if(Cap1==1 && Cap2==1 && Cap3==1){
				//EnvoiSignal
				TIM6_Config(f);
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000");
			}
			//Capteur 1
			if(C1 == 0x1){
				Cap1=1;
			}
			if(C2 == 0x1){
				Cap2=1;
			}
			if(C3 == 0x1){
				Cap3=1;
			}
		}
		else if(i==2)
		{
			if(f>0x1F00)
			{
				f=0x101A;
			}
			f=f+0xA;
			if(Cap1==1 || Cap2==1 || Cap3==1)
			{
				TIM6_Config(f);
			  AllumerSon();
			}
			//Bouton 0
			if ((TP_State.TouchDetected) && (TP_State.Y <= 255) && (TP_State.Y >= 215) && (TP_State.X >= 100) && (TP_State.X <= 140))
			{
				CodeTaper = CodeTaper*10; 
				j++;
			}
			//Bouton 1
			if ((TP_State.TouchDetected) && (TP_State.Y <= 129) && (TP_State.Y >= 89) && (TP_State.X >= 58) && (TP_State.X <= 98))
			{
				CodeTaper = CodeTaper*10+1; 
				j++;
			}
			//Bouton 2
			if ((TP_State.TouchDetected) && (TP_State.Y <= 129) && (TP_State.Y >= 89) && (TP_State.X >= 100) && (TP_State.X <= 140))
			{
				CodeTaper = CodeTaper*10+2; 
				j++;
			}
			//Bouton 3
			if ((TP_State.TouchDetected) && (TP_State.Y <= 129) && (TP_State.Y >= 89) && (TP_State.X >= 142) && (TP_State.X <= 182))
			{
				CodeTaper = CodeTaper*10+3; 
				j++;
			}
			//Bouton 4
			if ((TP_State.TouchDetected) && (TP_State.Y <= 170) && (TP_State.Y >= 130) && (TP_State.X >= 58) && (TP_State.X <= 98))
			{
				CodeTaper = CodeTaper*10+4; 
				j++;
			}
			//Bouton 5
			if ((TP_State.TouchDetected) && (TP_State.Y <= 170) && (TP_State.Y >= 130) && (TP_State.X >= 100) && (TP_State.X <= 140))
			{
				CodeTaper = CodeTaper*10+5; 
				j++;
			}
			//Bouton 6
			if ((TP_State.TouchDetected) && (TP_State.Y <= 170) && (TP_State.Y >= 130) && (TP_State.X >= 142) && (TP_State.X <= 182))
			{
				CodeTaper = CodeTaper*10+6; 
				j++;
			}
			//Bouton 7
			if ((TP_State.TouchDetected) && (TP_State.Y <= 213) && (TP_State.Y >= 173) && (TP_State.X >= 58) && (TP_State.X <= 98))
			{
				CodeTaper = CodeTaper*10+7; 
				j++;
			}
			//Bouton 8
			if ((TP_State.TouchDetected) && (TP_State.Y <= 213) && (TP_State.Y >= 173) && (TP_State.X >= 100) && (TP_State.X <= 140))
			{
				CodeTaper = CodeTaper*10+8;
				j++;
			}
			//Bouton 9
			if ((TP_State.TouchDetected) && (TP_State.Y <= 213) && (TP_State.Y >= 173) && (TP_State.X >= 142) && (TP_State.X <= 182))
			{
				CodeTaper = CodeTaper*10+9; 
				j++;
			}
			if (CodeTaper == Code)
			{
				C1=0;
				C2=0;
				C3=0;
				Cap1=0;
				Cap2=0;
				Cap3=0;
				CodeTaper = 0;
				j = 0;
				i=i-2;
				CreatePremierMenu();
				EnvoiSignal((unsigned char*)"000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000");
				waitMS(250);
				EteindreSon();
			}
			if (CodeTaper != Code && j==4)
			{
				CreateBloque();
			}
			if (j==1)
			{
				CreateCode1();
				waitMS(250);
			}
			if (j==2)
			{
				CreateCode2();
				waitMS(250);
			}
			if (j==3)
			{
				CreateCode3();
				waitMS(250);
			}
			if (j==4)
			{
				CreateCode4();
				waitMS(250);
			}
		}
		else
		{
		}
  }
}

/**
  * @brief TIM MSP Initialization 
  *        This function configures the hardware resources used in This application: 
  *           - Peripheral's clock enable
  *           - Peripheral's GPIO Configuration  
  * @param htim: TIM handle pointer
  * @retval None
  */
void HAL_TIM_Base_MspInit(TIM_HandleTypeDef *htim)
{
  /*##-1- Enable peripherals and GPIO Clocks #################################*/
  /* TIMx Peripheral clock enable */
  __HAL_RCC_TIM3_CLK_ENABLE();
	__HAL_RCC_TIM6_CLK_ENABLE();

  /*##-2- Configure the NVIC for TIMx ########################################*/
  /* Set the TIMx priority */
  HAL_NVIC_SetPriority(TIM3_IRQn, 0, 1);
  
  /* Enable the TIMx global Interrupt */
  HAL_NVIC_EnableIRQ(TIM3_IRQn);
}

/**
  * @brief  Initializes the STM32F429I-DISCO's LCD and LEDs resources.
  * @param  None
  * @retval None
  */
static void BSP_Config(void)
{
  /* Initialize STM32F429I-DISCO's LEDs */
  BSP_LED_Init(LED3);
  BSP_LED_Init(LED4);
  
  /* Initializes the SDRAM device */
  BSP_SDRAM_Init();
  
  /* Initialize the Touch screen */
  BSP_TS_Init(240, 320);
  
  /* Enable the CRC Module */
  __HAL_RCC_CRC_CLK_ENABLE();
}

/**
  * @brief  BSP_Background.
  * @param  None
  * @retval None
  */
#ifdef __ICCARM__
  #pragma optimize=none
#endif
void BSP_Background(void)
{
  //BSP_LED_Toggle(LED3);
  //BSP_LED_Toggle(LED4);
  
  /* Capture input event and update cursor */
  if(GUI_Initialized == 1)
  {
    BSP_Pointer_Update();
  }
}

/**
  * @brief  Provide the GUI with current state of the touch screen
  * @param  None
  * @retval None
  */
void BSP_Pointer_Update(void)
{
  GUI_PID_STATE TS_State;
  static TS_StateTypeDef prev_state;
  TS_StateTypeDef  ts;
  uint16_t xDiff, yDiff;  
  
  BSP_TS_GetState(&ts);
  
  TS_State.Pressed = ts.TouchDetected;

  xDiff = (prev_state.X > ts.X) ? (prev_state.X - ts.X) : (ts.X - prev_state.X);
  yDiff = (prev_state.Y > ts.Y) ? (prev_state.Y - ts.Y) : (ts.Y - prev_state.Y);
  
  if((prev_state.TouchDetected != ts.TouchDetected )||
     (xDiff > 3 )||
       (yDiff > 3))
  {
    prev_state.TouchDetected = ts.TouchDetected;
    
    if((ts.X != 0) &&  (ts.Y != 0)) 
    {
      prev_state.X = ts.X;
      prev_state.Y = ts.Y;
    }
      
    if(CALIBRATION_IsDone())
    {
      TS_State.Layer = 0;
      TS_State.x = CALIBRATION_GetX (prev_state.X);
      TS_State.y = CALIBRATION_GetY (prev_state.Y);
    }
    else
    {
      TS_State.Layer = 0;
      TS_State.x = prev_state.X;
      TS_State.y = prev_state.Y;
    }
    
    GUI_TOUCH_StoreStateEx(&TS_State);
  }
}

/**
  * @brief  System Clock Configuration
  *         The system Clock is configured as follow : 
  *            System Clock source            = PLL (HSE)
  *            SYSCLK(Hz)                     = 180000000
  *            HCLK(Hz)                       = 180000000
  *            AHB Prescaler                  = 1
  *            APB1 Prescaler                 = 4
  *            APB2 Prescaler                 = 2
  *            HSE Frequency(Hz)              = 8000000
  *            PLL_M                          = 8
  *            PLL_N                          = 360
  *            PLL_P                          = 2
  *            PLL_Q                          = 7
  *            VDD(V)                         = 3.3
  *            Main regulator output voltage  = Scale1 mode
  *            Flash Latency(WS)              = 5
  * @param  None
  * @retval None
  */
static void SystemClock_Config(void)
{
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_OscInitTypeDef RCC_OscInitStruct;
  
  /* Enable Power Control clock */
  __HAL_RCC_PWR_CLK_ENABLE();
  
  /* The voltage scaling allows optimizing the power consumption when the device is 
     clocked below the maximum system frequency, to update the voltage scaling value 
     regarding system frequency refer to product datasheet.  */
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
  
  /* Enable HSE Oscillator and activate PLL with HSE as source */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = 8;
  RCC_OscInitStruct.PLL.PLLN = 360;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 7;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);
  
  /* Activate the Over-Drive mode */
  HAL_PWREx_EnableOverDrive();
  
  /* Select PLL as system clock source and configure the HCLK, PCLK1 and PCLK2 
  clocks dividers */
  RCC_ClkInitStruct.ClockType = (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2);
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;  
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;  
  HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5);
}


//HP
void TIM6_Config(int f)
{
  static TIM_HandleTypeDef htim;
  TIM_MasterConfigTypeDef  sMasterConfig;
  
  /*##-1- Configure the TIM peripheral #######################################*/
  /* Time base configuration */
  htim.Instance = TIM6;
  
  htim.Init.Period = f;      
  htim.Init.Prescaler = 0;       
  htim.Init.ClockDivision = 0;    
  htim.Init.CounterMode = TIM_COUNTERMODE_UP; 
  HAL_TIM_Base_Init(&htim);

  /* TIM6 TRGO selection */
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  
  HAL_TIMEx_MasterConfigSynchronization(&htim, &sMasterConfig);
  
  /*##-2- Enable TIM peripheral counter ######################################*/
  HAL_TIM_Base_Start(&htim);
}

static void Error_Handler(void)
{
  /* Turn LED4 on */
  BSP_LED_On(LED4);
  while(1)
  {
  }
}

void DAC_Ch2_SineWaveConfig(void)
{
	/*##-1- Initialize the DAC peripheral ######################################*/
  if(HAL_DAC_Init(&DacHandle) != HAL_OK)
  {
    /* Initialization Error */
    Error_Handler();
  }
  
  /*##-1- DAC channel1 Configuration #########################################*/
  sConfig2.DAC_Trigger = DAC_TRIGGER_T6_TRGO;
  sConfig2.DAC_OutputBuffer = DAC_OUTPUTBUFFER_ENABLE;  

  if(HAL_DAC_ConfigChannel(&DacHandle, &sConfig2, DACx_CHANNEL2) != HAL_OK)
  {
    /* Channel configuration Error */
    Error_Handler();
  }
  
  /*##-2- Enable DAC Channel1 and associated DMA #############################*/
  if(HAL_DAC_Start_DMA(&DacHandle, DACx_CHANNEL2, (uint32_t*)Sine8bit, 32, DAC_ALIGN_8B_R) != HAL_OK)
  {
    /* Start DMA Error */
    Error_Handler();
  }
}

void AllumerSon(void){
	HAL_DAC_DeInit(&DacHandle);
	DAC_Ch2_SineWaveConfig();
}

void EteindreSon(void){
	HAL_DAC_DeInit(&DacHandle);
}


#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

