*** Settings ***
Library                                SeleniumLibrary
Resource                               ../../../Common.robot
Variables                              ../../../../Tests/Shop/Discover_Variables.yaml
Resource                               ../../../../Resources/Local_Keywords.robot

*** Keywords ***

Quick Action Button Section

    # Verifying  Quick Action Section Banner                Testcase:92542
    Section Verification                xpath=//div[@class='d-flex flex-wrap justify-content-center icon-wrapper']    Quick_Action_Banner

    # Verifying Each Banner In Quick Action Section
    ${Quick_Button}  Set Variable                 1
    WHILE  ${Quick_Button} < 5
      # Checking Redirection After Clicking Each Button  Of Quick Action Section 
      # Verifying Url After Redirection & Taking Screenshot        Testcase:92543,92544,92545,92546
      Redirection On Clicking           xpath=(//div[contains(@class,"relative title-max-wid")])[${Quick_Button}]   ${Shop_SubNavBar_URL}[${Quick_Button}]    QuickAction[${Quick_Button}]  
      Sleep                            200ms    # Required Sleep
      ${Quick_Button}=   Evaluate                ${Quick_Button} + 1
    END
