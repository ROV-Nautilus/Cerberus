/**
  ******************************************************************************
  * @file    Template/main.c 
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    20-September-2013
  * @brief   Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2013 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "LEDs.h"
#include "HP.h"
#include "Affichage.h"
#include "Capteurs.h"


/** @addtogroup Template
  * @{
  */ 

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/**
  * @brief   Main program
  * @param  None
  * @retval None
  */
int main(void)
{
	int i = 0;
	int Cap1 = 0;
	int Cap2 = 0;
	int Cap3 = 0;
	uint8_t C1;
	uint8_t C2;
	uint8_t C3;
  static TP_STATE* TP_State;
	
  /*!< At this stage the microcontroller clock setting is already configured, 
       this is done through SystemInit() function which is called from startup
       files (startup_stm32f429_439xx.s) before to branch to application main. 
       To reconfigure the default setting of SystemInit() function, refer to
       system_stm32f4xx.c file
     */  
	
	//Initialisation du HP
	HPInit();
	
	//Initialisation du LCD et du premierMenu
  Debut();
	
	/* Touch Panel configuration */
  PremierMenu();
	
	/* TIM6 Configuration ------------------------------------------------------*/
  TIM6_Config(); 
	
	//Initialisation des capteurs
	InitCapteur();
	
  while (1)
  {
		TP_State = IOE_TP_GetState();
		if(i==0)
		{
			//Bouton On
			EnvoiSignal((unsigned char*)"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
			if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 30) && (TP_State->X <= 100))
			{
				//Affichage Menu 2
				DeuxiemeMenu();
				i++;
				EnvoiSignal((unsigned char*)"000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000");
				waitMS(500);
			}
			//Bouton Off
			else if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 140) && (TP_State->X <= 210))
			{
				//Eteindre Appareil
			}
			else
			{
			}
		}
		else if(i==1)
		{
			//Bouton On
			EnvoiSignal((unsigned char*)"000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000");
			if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 30) && (TP_State->X <= 100))
			{
				TroisiemeMenu();
				i++;
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
				waitMS(500);
			}
			//Bouton Off
			else if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 140) && (TP_State->X <= 210))
			{
				PremierMenu();
				i--;
				EnvoiSignal((unsigned char*)"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
				waitMS(500);
			}
			
		}
		else if(i==2)
		{
			//Recuperation des valeurs des capteurs
			C1 = Capteur1();
			C2 = Capteur2();
			C3 = Capteur3();
			
			//Vert
			if(Cap1==0 && Cap2==0 && Cap3==0){
			EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
			}
			
			//Bouton On
			if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 30) && (TP_State->X <= 100))
			{
			}
			//Bouton Off
			else if ((TP_State->TouchDetected) && (TP_State->Y <= 200) && (TP_State->Y >= 130) && (TP_State->X >= 140) && (TP_State->X <= 210))
			{
				DeuxiemeMenu();
				i--;
				EnvoiSignal((unsigned char*)"000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000000000000000000001000000");
				waitMS(500);
				C1=0;
				C2=0;
				C3=0;
				Cap1=0;
				Cap2=0;
				Cap3=0;
				EteindreSon();
			}
			//Capteur1
			if(Cap1==1 && Cap2==0 && Cap3==0){
				//EnvoiSignal
				AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000");
			}
			if(Cap1==0 && Cap2==1 && Cap3==0){
				//EnvoiSignal
				AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000");
			}
			if(Cap1==0 && Cap2==0 && Cap3==1){
				//EnvoiSignal
				AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000");
			}
			if(Cap1==0 && Cap2==1 && Cap3==1){
				//EnvoiSignal
				AllumerSon();
				EnvoiSignal((unsigned char*)"010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000");
			}
			if(Cap1==1 && Cap2==0 && Cap3==1){
				//EnvoiSignal
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000000000000100000000000000000000000100000000000000");
				}
			if(Cap1==1 && Cap2==1 && Cap3==0){
				//EnvoiSignal
			  AllumerSon();
				EnvoiSignal((unsigned char*)"000000000100000000000000000000000100000000000000000000000100000000000000000000000100000000000000010000000000000000000000010000000000000000000000");
			  }
			if(Cap1==1 && Cap2==1 && Cap3==1){
				//EnvoiSignal
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
		else
		{
		}
  }
}

#ifdef  USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
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

/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
