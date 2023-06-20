*** Settings ***
Library                                                SeleniumLibrary
Resource                                               ../../../Common.robot
Variables                                              ../../../Common_Variables.yaml
Variables                                              ../../../../Tests/Shop/JioFi_Variables.yaml



*** Keywords ***
Landing on JioFi Page  
    # Visiting Jio.Com Website And Go To Shop Tab      Testcase:92705
    Visit Jio.com And Goto                             ${Shop}
    URL Validation                                     ${Shop_SubNavBar_URL[${0}]}
    #Clicking On JioFi From Sub Navigation Bar
    Wait For And Click Element                         ${JioFi}
    URL Validation                                     ${Shop_SubNavBar_URL[${3}]}
    #CSS Verification Of Underline
    Wait Until Keyword Succeeds    1 min  0 min        CSS Verification                                  //li[@onclick="window.location.href='/shop/en-in/c/jiofi'"]    border-bottom-color     rgba(232, 232, 252, 1)
    # Setting Screenshot Directory For Jiofi Page 
    Set Screenshot Directory                           ./Results/Shop/Shop/JioFi_Screenshots/
    Take Page Screenshot                               JioFiPage_Loaded
    # Setting Sheet Name As Test Variable
    ${sheet} =    Set Variable                         Shop_JioFi
    Set Test Variable                                  ${sheet}
