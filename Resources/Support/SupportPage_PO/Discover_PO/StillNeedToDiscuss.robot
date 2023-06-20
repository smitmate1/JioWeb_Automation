*** Settings ***
Resource                           ../../../Common.robot
Resource                           ../../../Excel_Activity.robot
Variables                          ../../../../Tests/Support/Discover_Variables.yaml

*** Keywords ***
Redirection, UI and Content of 'Still need to discuss something?' section verification

    #92453

    #Scroll upto Still need to discuss something? section
    Scroll To                                   xpath=//section[@class='j-container bg--primary-background']
    
    #Still need to discuss something? section verification
    Section Verification                        xpath=//section[@class='j-container bg--primary-background']                  ${stillneed_text[0]}
    
    #Heading of 'Still need to discuss something?'
    Text Verification                           xpath=//h2[normalize-space()='Still need to discuss something?']                            ${stillneed_text[0]}
    
    #Subtext under Heading
    Text Verification                           xpath=//div[@class='j-contentBlock__description j-text-body-m j-color-primary-grey-80']     ${stillneed_text[1]}
    
    #92454 to 92456
    #Text and Redirection Verification of Three buttons
    FOR    ${buttons}    IN RANGE    1   4
        
        #Element Verification of Buttons
        Wait For And verify Element             xpath=(//button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "])[${buttons}]
        
        #TExt Verification of Buttons
        Text Verification                       xpath=(//button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "])[${buttons}]    ${stillneed_buttons_text}[${buttons-1}]
        
        #Click on every button
        wait for and Click Element              xpath=(//button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "])[${buttons}] 
        IF  ${buttons} == 1
            Sleep    150ms
            #Cross button of popup
            Wait For And Click Element          xpath=//img[@src="https://jep-asset.akamaized.net/jiostaticresources/chat/revamp/chatbot/icon-close.svg"]
            URL Validation                      ${stillneed_urls}[${buttons-1}]
            Take Page Screenshot                ${stillneed_buttons_text}[${buttons-1}]
        ELSE
            URL Validation                      ${stillneed_urls}[${buttons-1}]
            Take Page Screenshot                ${stillneed_buttons_text}[${buttons-1}]
            Go Back
        END           
    END   

"Find a Store" is Redirecting To The Relevant Page Verification
    #Scroll To to "Still need to discuss something" section
    Scroll To                                   xpath=(//span[@class="l-breakpoint--desktop sp--huge pd--top j-Space__vertical j-Space"])[7]
    Sleep    1s
    #Redirection to Find a Store from Still need to discuss something section
    Redirection On Clicking                     xpath=(//div[normalize-space()='Find a store'])[1]    ${LocateUsURL}    Sc_LocateUs