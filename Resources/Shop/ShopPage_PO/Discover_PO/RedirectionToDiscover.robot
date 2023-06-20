*** Settings ***
Library                                                 SeleniumLibrary
Resource                                                ../../../Common.robot
Variables                                               ../../../Common_Variables.yaml


*** Keywords ***
Landing on Discover Page                                # Testcase:92535
      
    #Clicking On Shop From Top Navigation Bar
    Visit Jio.com And Goto                             ${Shop}

    #Verifying Discover Page Is Open    
    URL Validation                                     ${Shop_SubNavBar_URL[${0}]}
    Sleep                                               200ms        # Required Sleep
    
    #Verifying Underline Is Present To Highlight Discover Tab
    Wait Until Keyword Succeeds    30 sec  1 sec       CSS Verification        //li[@class='cursor-pointer active']   border-bottom-color     rgba(232, 232, 252, 1)
    
    #Setting Folder Path To Save Screenshots
    Set Screenshot Directory                           ./Results/Shop/Shop/Discover_Screenshots/
    
    #Taking Screenshot Of Loaded Page
    Take Page Screenshot                               DiscoverPage_Loaded
    
    #Setting Temporary Variable For Excel 
    ${sheet} =    Set Variable                         Shop_Discover
    Set Test Variable                                  ${sheet}
    