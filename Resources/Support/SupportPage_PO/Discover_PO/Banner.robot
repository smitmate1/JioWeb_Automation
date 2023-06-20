*** Settings ***
Resource                           ../../../Common.robot
Resource                           ../../../Excel_Activity.robot
Variables                          ../../../../Tests/Support/Discover_Variables.yaml
Resource                           ../../../Local_Keywords.robot

*** Keywords ***
Click on Search box from Banner and Verify Contents of SearchBar Verification
    #92458
    #Verifying if Searchbar is present
    Wait For And Verify Element       xpath=//input[@id='supportSearchtxt']
    #Verifying placeholder 
    Wait For And Verify Element       xpath=//input[@aria-label="Type your query"]    
    #Entering text
    Wait For And Input Text           xpath=//input[@id='supportSearchtxt']    j
    Sleep    500ms
    #clearing text
    Press Keys              xpath=//input[@id='supportSearchtxt']   BACKSPACE 
    Sleep    500ms
    #Scrolling down  to next section to view whole suggestion box
    Scroll To                         xpath=//div[normalize-space()='Shortcuts to most used services']    
    #Verifying if Whole Suggestion Box is present
    Wait For And Verify Element       xpath=//div[@id='searchList-support']
    #Scroll bar cannot be verified as it has no xpath
    #Quicklinks
    Wait For And Verify Element       xpath=//div[@id='quicklink-list-id-support']
    #Suggested Links
    Wait For And Verify Element       xpath=//div[@id='suggested-list-id-support']
    Click on Any QuickLinks from Search Verification
    Enter Random Strings of Length Three Verification
    #92461
    #Chatbot Verification
    #Click on Chatbot
    Wait For And Click Element        xpath=//img[@class='chatbotImg open_chatbox']
    Chat-bot verification
   
Click on Any QuickLinks from Search Verification
    #92459
    #Clicking on Recharge From the Quickilinks Suggestions 
    Redirection On Clicking           xpath=//div[@id='quicklink-list-id-support']//li[1]//a[1]    ${SearchRechargeURL}    Sc_Recharge
   
Enter Random Strings of Length Three Verification
    #92460
    #Entering Random String of length three in the Search Bar
    Wait For And Click Element        xpath=//*[@id="supportSearchtxt"]
    Wait For And Input Text           xpath=//input[@id='supportSearchtxt']        ygf   
    #Verifying if Suggested List Appears
    Wait For And Verify Element       xpath=//div[@id='suggested-list-id-support']
    #Verifying Suggested List Contents
    Wait For And Verify Content       xpath=//a[@href='/en-in/support-search?searchkeyword=myjio']                MyJio
    Wait For And Verify Content       xpath=//a[contains(@href,'/en-in/support-search?searchkeyword=recharge')]   Recharge
    