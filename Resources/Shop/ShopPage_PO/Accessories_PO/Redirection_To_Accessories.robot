*** Settings ***
Library                                               SeleniumLibrary
Resource                                              ../../../Common.robot
Variables                                             ../../../Common_Variables.yaml
Variables                                             ../../../../Tests/Shop/Accessories_Variables.yaml



*** Keywords ***
Landing on Accessories Page
    #Clicking On Shop From Top Navigation Bar
    Visit Jio.com And Goto                             ${Shop}
    
    #Clicking On Accessories From Sub Navigation Bar
    Wait For And Click Element                         ${Accessories}
    
    #Verifying Accessories Page Is Open    
    URL Validation                                     ${Shop_SubNavBar_URL[${4}]}
    
    #Verifying Underline Is Present To Highlight Accessories Tab
    Wait Until Keyword Succeeds    30 sec  1 sec       CSS Verification        //li[@onclick="window.location.href='/shop/en-in/c/jioaccessories'"]    border-bottom-color     rgba(232, 232, 252, 1)
    
    #Setting Folder Path To Save Screenshots
    Set Screenshot Directory                           ./Results/Shop/Shop/Accessories_Screenshots/
    
    #Taking Screenshot Of Loaded Page
    Take Page Screenshot                               AccessoriesPage_Loaded
    
    #Setting Temporary Variable For Excel 
    ${sheet} =    Set Variable                         Shop_Accessories
    Set Test Variable                                  ${sheet}
    
