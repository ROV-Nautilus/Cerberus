#include "stm32f4xx.h"
#include "HP.h"
#include <stdio.h>
#include "stm32f4xx_hal_dac.h"
#include "stm32f429i_discovery.h"
#include "main.h"

/* Private define ------------------------------------------------------------*/
#define DAC_DHR12R2_ADDRESS    0x40007414
#define DAC_DHR8R1_ADDRESS     0x40007410

/* Private variables ---------------------------------------------------------*/
DAC_HandleTypeDef    DacHandle;
DAC_ChannelConfTypeDef sConfig;
const uint16_t Sine12bit[32] = {
                      2047, 2447, 2831, 3185, 3498, 3750, 3939, 4056, 4095, 4056,
                      3939, 3750, 3495, 3185, 2831, 2447, 2047, 1647, 1263, 909, 
                      599, 344, 155, 38, 0, 38, 155, 344, 599, 909, 1263, 1647};

const uint8_t Escalator8bit[6] = {0x0, 0x33, 0x66, 0x99, 0xCC, 0xFF};

/**
  * @brief  TIM6 Configuration
  * @note   TIM6 configuration is based on CPU @180MHz and APB1 @45MHz
  * @note   TIM6 Update event occurs each TIM6CLK(MHz)/256    
  * @param  None
  * @retval None
  */
void TIM6_Config(void)
{
  /* TIM6CLK = HCLK / 4 = SystemCoreClock /4 */
  
	TIM_HandleTypeDef TIM_TimeBaseStructure;
  TIM_MasterConfigTypeDef  sMasterConfig;
	
  /* TIM6 Periph clock enable */
  __HAL_RCC_TIM6_CLK_ENABLE();

  /* Time base configuration */
  TIM_TimeBaseStructure.Init.Period = 0xC7F;
  TIM_TimeBaseStructure.Init.Prescaler = 0;
  TIM_TimeBaseStructure.Init.ClockDivision = 0;
  TIM_TimeBaseStructure.Init.CounterMode = TIM_COUNTERMODE_UP;
	HAL_TIM_Base_Init(&TIM_TimeBaseStructure);

  /* TIM6 TRGO selection */
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  
	HAL_TIMEx_MasterConfigSynchronization(&TIM_TimeBaseStructure, &sMasterConfig);
  /* TIM6 enable counter */
  HAL_TIM_Base_Start(&TIM_TimeBaseStructure);
}

/**
  * @brief  DAC  Channel2 SineWave Configuration
  * @param  None
  * @retval None
  */
void DAC_Ch2_SineWaveConfig(void)
{
}

static void Error_Handler(void)
{
  /* Turn LED4 on */
  BSP_LED_On(LED4);
  while(1)
  {
  }
}

/**
  * @brief  DAC Channel1 Escalator Configuration
  * @param  None
  * @retval None
  */

void DAC_Ch1_EscalatorConfig(void)
{
  /*##-1- DAC channel1 Configuration #########################################*/
  sConfig.DAC_Trigger = DAC_TRIGGER_T6_TRGO;
  sConfig.DAC_OutputBuffer = DAC_OUTPUTBUFFER_ENABLE;  

  if(HAL_DAC_ConfigChannel(&DacHandle, &sConfig, DACx_CHANNEL1) != HAL_OK)
  {
    /* Channel configuration Error */
    Error_Handler();
  }
  
  /*##-2- Enable DAC Channel1 and associated DMA #############################*/
  if(HAL_DAC_Start_DMA(&DacHandle, DACx_CHANNEL1, (uint32_t*)Escalator8bit, 6, DAC_ALIGN_8B_R) != HAL_OK)
  {
    /* Start DMA Error */
    Error_Handler();
  }
}

void AllumerSon(void){
	HAL_DAC_DeInit(&DacHandle);
	DAC_Ch1_EscalatorConfig();
	DAC_Ch2_SineWaveConfig();
}

void EteindreSon(void){
	//DAC_Cmd(DAC_Channel_2, DISABLE);
}

void HPInit(){
	/*##-1- Configure the DAC peripheral #######################################*/
  DacHandle.Instance = DAC;
	
}
