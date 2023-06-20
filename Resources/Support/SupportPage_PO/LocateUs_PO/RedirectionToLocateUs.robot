*** Settings ***
Library                            SeleniumLibrary
Resource                           ../../../Common.robot
Resource                           ../../../Excel_Activity.robot
Variables                          ../../../../Tests/Support/Discover_Variables.yaml

*** Keywords ***
Landing on Locate Us Page

    #Go to Support Page 
    Visit Jio.com And Goto                                ${Support}

    #Verification of Locate us on top nav bar
    Wait For And Verify Element                           ${Support_NavBar[0]}

    #text verification of Locate us
    Text Verification                                     ${Support_NavBar[0]}            Locate Us

    #redirection to Locate Us
    Wait For And Click Element                            ${Support_NavBar[0]}
    
    #Validating URL of Locate Us
    URL Validation                                        ${Support_SubNavbarURLs[0]}

    #It is an issue on prod which is yet to be resolved
    Run Keyword And Continue On Failure                   CSS Verification                                      xpath://li[@onclick="window.location.href='/selfcare/locate-us'"]   border-bottom    3px solid rgba(232, 232, 252) 
    Set Screenshot Directory                              ./Results/Support/Support/LocateUs_Screenshots/
    Reading Data of LocateUs Support Page from Excel
    Take Page Screenshot                                  LocateUsPage_Loaded
    