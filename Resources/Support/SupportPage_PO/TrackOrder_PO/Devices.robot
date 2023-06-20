*** Settings ***
Resource                    ../../../Common.robot
Variables                   ../../../../Tests/Support/TrackOrder_Variables.yaml
Resource                    ../../../Excel_Activity.robot
Resource                    ../../../Local_Keywords.robot

*** Keywords ***
Check Redirection of Devices option
    # Testcase : 92611
    # Check Devices option is visible on Track order page
    Wait For And Verify Element        xpath=//a[@aria-label='Devices']//div[@class='j-listBlock__main']
    # Devices Option
    Text Verification                  xpath=//div[@class='j-text j-text-body-s'][normalize-space()='Devices']    Devices
    # TestCase : 92612
    # Click on Devices Option
    Redirect and continue              xpath=//a[@aria-label='Devices']//div[@class='j-listBlock__block-text']    https://www.jio.com/shop/viewOrderDetails    Sc_RedirectionTodevicesPage
    #View Order Details page
    Check user gets an error toast

UI of 'Devices' Page Verification
    # Testcase : 92613
    # clicking on Devices
    Check Redirection of Devices option
    #View Order Details Heading
    Wait For And Verify Content        xpath=//h1[normalize-space()='View Order Details']                         ${Devices_Heading}
    # Type order placeholder
    Element Attribute Verification     xpath=//input[@id='orderNo']    placeholder    Type Order Number
    # Track details button
    Wait For And Verify Element        xpath=//button[@id='guestUserOrderDetails']
    Track Order Button Activates

Track Order Button Activates
    # Testcase : 92614
    # Input text
    Wait For And Input Text            xpath=//input[@id='orderNo']    1234
    # Track Order button activates
    Wait Until Element Is Enabled      xpath=//button[@id='guestUserOrderDetails']

Check user gets an error toast 
    # TestCase : 92615
    # Enter OrderID
    Wait For And Input Text            xpath=//input[@id='orderNo']    abcdefgh 
    #click on track details button
    Wait For And Click Element         xpath=//button[@id='guestUserOrderDetails']
    # Please wait text appears for a fraction of second
    Element Should Contain             xpath=//button[@id='guestUserOrderDetails']    Please wait
    # Invalid Order number text appears    
    Text Verification                  xpath=//div[@id='errorResponse']               Invalid Order number