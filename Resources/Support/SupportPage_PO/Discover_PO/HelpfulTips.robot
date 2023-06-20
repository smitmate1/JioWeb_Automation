*** Settings ***
Resource                           ../../../Excel_Activity.robot
Resource                           ../../../Common.robot
Resource                           ../../../Local_Keywords.robot
Variables                          ../../../../Tests/Support/Discover_Variables.yaml

*** Keywords ***
UI and content of Helpful Tips section verification

    #92446
    #scroll upto Helpful Tips
    Scroll To                                 xpath=//section[@class="j-container "]
    #section verification for Helpful Tips
    Section Verification                      xpath=//section[@class="j-container "]     ${helpfultips_texts[0]}
    #Helpful Tips Heading Verification
    Wait For And Verify Element               xpath=//h2[@class='j-heading j-text-heading-l']    
    Text Verification                         xpath=//h2[@class='j-heading j-text-heading-l']      ${helpfultips_texts[0]}
    #92447
    #clicking on every tip and validating redirection

    FOR  ${helpful_tips}  IN RANGE  1  4 
        
        # Scrolling upto each tip present under "Helpful tips" section
        Scroll To                                    xpath=(//div[@class="j-card size--xs card-horizontal j-card__shadow shadow-vertical-mg hover-transition bg--primary-background"])[${helpful_tips}]
       
       # Clicking on each tip
        Wait For And Click Element                   xpath=(//div[@class="j-card size--xs card-horizontal j-card__shadow shadow-vertical-mg hover-transition bg--primary-background"])[${helpful_tips}]
       
        #Checking URL for the tip redirected
        URL Validation                        ${helpfultips_urls}[${helpful_tips-1}]
        Take Page Screenshot                  ${helpfultips_scname}[${helpful_tips-1}]
        Go Back
    END

    #view more helpful tips button verification
    Wait For And Verify Element               xpath=//button[@aria-label='View more helpful tips']
    Text Verification                         xpath=//button[@aria-label='View more helpful tips']    ${helpfultips_texts[1]}

    #92448
    #View more helpful tips redirection checking
    Redirection On Clicking                   xpath=//button[@aria-label='View more helpful tips']    ${helpfultips_URLs[3]}     viewmorehelpfultips 

Scroll down to Helpful Tips Section Check Redirection and UI verification
    #Scrolling down to Helpful Tips section
    #92449
    Scroll To                                 xpath=//button[normalize-space()='View more helpful tips']
    Wait For And Verify Element               xpath=//button[normalize-space()='View more helpful tips']
    #Check redirection of View More Helpful Tips   
    Redirect and continue                     xpath=//button[normalize-space()='View more helpful tips']    ${helpfultips_URLs[0]}    Sc_HelpfulTips
    #Check onclicking view more helpful videos user is redirected to Jio Helpful Tips Page  
    #Title & SubTitle
    Wait For And Verify Content               xpath=//h1[contains(text(),'Jio helpful tips')]     ${JioHelpfulTips1[0]}
    Wait For And Verify Content               xpath=//p[contains(text(),'Mobile users can track and manage mobile data usage.')]      ${JioHelpfulTips1[1]} 
    Check UI
     
#Check UI Of Helpful Tips Page 
Check UI   
    FOR    ${Jio_helpful_tips}    IN RANGE   1    9  
        #Scroll to Every Element and verify 
        Sleep    3s
        Scroll To                             xpath=(//div[@class="card_visible_list"])[${Jio_helpful_tips}]
        Sleep    200ms
        Wait For And Click Element            xpath=(//div[@class="card_visible_list"])[${Jio_helpful_tips}]
        Redirection Of Helpful Tips            ${Jio_helpful_tips}     
    END

Check UI and Contents of Helpful Tips Page
    [Arguments]    ${helpful_tips_UI}
    #Title Content Verification
    Text Verification                         xpath=//h1[@class="j-contentBlock__title j-heading j-text-heading-l"]   ${JioHelpfulTips3}[${helpful_tips_UI-1}]
    #Verifying Image of Each Page
    Wait For And Verify Element                        xpath=//img[@class="w-100"]
    #Verifying whole Body Content
    Scroll To                                 xpath=//div[@class='content-information-wrapper my-3 p-0']
    Text Verification                         xpath=//div[@class='content-information-wrapper my-3 p-0']   ${TextVerify${helpful_tips_UI}}
    #Verifying Related Helpful Tips
    Wait For And Verify Element               xpath=(//section[@class="j-container "])[2]

Redirection Of Helpful Tips
    [Arguments]    ${helpful_tips_cards}
    #Validating URL of every Page of Helpful Tips
    URL Validation        ${helpfultips_URLs[0]}
    Take Page Screenshot       Sc_HelpfulTip${helpful_tips_cards}
    #Verifying contents of Every Helpful Tip Page
    Check UI and Contents of Helpful Tips Page    ${helpful_tips_cards}
    Go Back