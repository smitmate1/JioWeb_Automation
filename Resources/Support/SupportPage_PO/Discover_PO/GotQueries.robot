*** Settings ***
Resource                           ../../../Common.robot
Resource                           ../../../Excel_Activity.robot
Resource                           ../../../Local_Keywords.robot
Variables                          ../../../../Tests/Support/Discover_Variables.yaml



*** Keywords ***
'Got queries? Check FAQs for answers'section verification
    
    #92440

    #Scroll till "Got queries? Check FAQs for answers "
    Scroll To                                          xpath=//div[@class='main_container']//section[@class='j-container']
    
    #section verification of Got queries? Check FAQs for answers
    Section Verification                               xpath=//div[@class='main_container']//section[@class='j-container']    ${Gotqueries_text[0]}
    
    #92441
    
    #Header Text verification
    Text Verification                                  xpath=//div[normalize-space()='Got queries? Check FAQs for answers']    ${Gotqueries_text[0]}
    
    #Subheader verification
    Text Verification                                  xpath=//div[normalize-space()='Select a service for related frequently asked questions.']    ${Gotqueries_text[1]}
    
    #92442

    #Scroll till modules of "Got queries? Check FAQs for answers "
    Scroll To                                          xpath=(//span[@class="l-breakpoint--desktop sp--huge pd--top j-Space__vertical j-Space"])[1]
    
    #Loop for redirection of different modules under "Got queries? Check FAQs for answers " section
    FOR    ${module}    IN RANGE   1    6

        #Modules of different section verification
        Wait For And Verify Element                    xpath=(//div[@class='j-text j-text-body-xs-bold'])[${module}]

        #Module Text verification
        Text Verification                              xpath=(//div[@class='j-text j-text-body-xs-bold'])[${module}]    ${gotqueries_modules_text}[${module-1}]
        
        #click on every module under the section
        Redirect and continue                          xpath=(//div[@class='j-text j-text-body-xs-bold'])[${module}]    ${Gotqueries_modules_urls}[${module-1}]    ${gotqueries_modules_text}[${module-1}]
        
        #92443
        
        #Devices Module UI and content verification
        IF  ${module} == 4

            #Module Header Verification
            wait for and verify Element                xpath=//h1[@class='j-heading j-text-heading-l mb-0 sp--m pd--right']
            
            #Module Header Text Verification
            Wait For And Verify Content                xpath=//h1[@class='j-heading j-text-heading-l mb-0 sp--m pd--right']    ${devicemodule_header}
            
            #Popping Menu  verification
            Wait For And Verify Element                xpath=//button[@class='j-button j-button-state__default j-button-size__medium secondary icon-primary icon-only']
            
            #Search Panel verification
            Wait For And Verify Element                xpath=//input[@id='supportSearchtxt']
            
            #select topic text Element and Content verification
            Wait For And Verify Element                xpath=//h2[normalize-space()='Select Topic']
            Sleep    150ms
            Wait For And Verify Content                xpath=//h2[normalize-space()='Select Topic']   ${Gotqueries_text[2]}
            
            #Tabs Element and content verification
            Wait For And Verify Element                xpath=//div[@id='SecondList']
            Wait For And Verify Content                xpath=//div[@id='SecondList']                  ${devicemodule_tabs_text}
            
            #Loop for iterating in devices under select topic                                
            FOR    ${device}    IN RANGE    1   7
                
                IF   ${device}!=2
                
                    #Clicking on Tabs present below select topic text
                    Scroll To                        xpath=(//div[@id="SecondList"]//button[@role="tab" ])[${device}]
                    Wait For And Click Element       xpath=(//div[@id="SecondList"]//button[@role="tab" ])[${device}]
                    Sleep    250ms

                    # For JioDive
                    IF   ${device}==1

                        #FAQ with Accordian content and UI verification of JioDive
            
                        Wait For And Verify Element        xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']
                        Wait For And Verify Content        xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']   ${devicemodule_faqs_text}[${device}]                
                    
                    #For Other Tabs excluding JioDive
                    ELSE

                        #FAQ with Accordian content and UI verification of tabs other than JioDive            
                        Wait For And Verify Element        xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']
                        Wait For And Verify Content        xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']   ${devicemodule_faqs_text}[${device-1}]                
                    
                    END
                
                # For JioPhone
                ELSE

                    #Click on Jiophone
                    Scroll To                           xpath=(//div[@id="SecondList"]//button[@role="tab" ])[${device}]
                    Wait For And Click Element          xpath=(//div[@id="SecondList"]//button[@role="tab" ])[${device}]
                    Sleep    250ms
                    #relevant options under JioPhone content verification
                    Wait For And Verify Content         xpath=//div[@class="sidebar_filter l-breakpoint--desktop"]//ul[@class="tab-order-list"]        ${devicemodule_relevantoptions_text}    
                    
                    #Loop for iterating relevant options under JioPhone
                    FOR    ${JioPhone_Options}    IN RANGE    1    6

                        #Clicking on relevant options under JioPhone 
                        Scroll To                       xpath=(//div[@aria-hidden='false']//ul//li)[${JioPhone_Options}]
                        Wait For And Click Element      xpath=(//div[@aria-hidden='false']//ul//li)[${JioPhone_Options}]
                        Sleep    2s  #required and fixed

                        #FAQ with Accordian content and UI verification of tabs present in JioPhone            
                        Wait For And Verify Element     xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']
                        Wait For And Verify Content     xpath=//div[@class='faqs_visible j-accordion j-accordion-plus-minus-icon j-accordion-wrapper table_size accordion-ques-text']   ${devicemodule_faqs1_text}[${JioPhone_Options}]    
                    
                    END       
                END
            END  
        END   
        Go Back
    END  

Popping Menu And Navigation Bar Is Redirecting Properly Verification
    #Scrolling down to Got Queries section on Support Discover Page
    Scroll To                                 xpath=//div[normalize-space()='Watch, learn, and resolve your issues']
    #Verifying if Got Queries section is Visible
    Wait For And Verify Content               xpath=//div[normalize-space()='Got queries? Check FAQs for answers']      ${GotQueries_heading}
    #Verify if Mobile Tab is present and Click on it
    Wait For And Verify Element               xpath=//div[@title='Mobile']
    Wait For And Click Element                xpath=//div[@title='Mobile']
    #Verify is Mobile FAQ is Visible
    Wait For And Verify Content               xpath=//h1[@class='j-heading j-text-heading-l mb-0 sp--m pd--right']      ${GotQueriesM}
    #Click on the Popping menu
    Wait For And Click Element                xpath=//button[@data-popup-open='modal-other-plans']
    Wait For And Verify Element               xpath=//div[@class='j-modal j-modal-closable j-modal-size-s j-modal-kind-dialog j-modal-dialog-scrollable j-modal-visible']//div[@class='j-modal-container']
    #Close icon
    Wait For And Verify Element               xpath=//button[@data-popup-close='modal-other-plans']//i[@class='j-button-icon']//*[name()='svg']
    Wait For And Click Element                xpath=//button[@data-popup-close='modal-other-plans']//i[@class='j-button-icon']
    #NavBar
    Wait For And Click Element                xpath=(//div[@id="SecondList"]//i[@class="j-button-icon"])[1]
    FOR    ${downarrow}    IN RANGE    1    11   
        Scroll To                             xpath=(//div[@id="SecondList"]//i[@class="j-button-icon"])[${downarrow}]  
        Wait For And Click Element            xpath=(//div[@id="SecondList"]//i[@class="j-button-icon"])[${downarrow}]
    END
    Confirm UI And Content For Options On Clicking '+' Sign Accordian Verification


Confirm UI And Content For Options On Clicking '+' Sign Accordian Verification
    #Scrolling down to Accordions of Mobile Tab "What is 5G ?"
    Scroll to                                 xpath=//div[contains(text(),'What is 5G')]
    Wait For And Verify Content               xpath=//div[contains(text(),'What is 5G ?')]                            ${Accdata1}  #Accordian data
    #Verifying is '+' icon is visible and clicking on it
    Wait For And Click Element                xpath=(//i[contains(@class,'j-button-icon accordion-icons')])[5]
    #Verifying is '-' icon is visible
    Wait For And Verify Element               xpath=(//i[contains(@class,'j-button-icon accordion-icons')])[5]
    #verifying content of Accordion
    Wait For And Verify Content               xpath=//div[@aria-hidden='false']//div[@class='sp--base']               ${Accdata2}    #Accordian data
    #Verifying if all three like,dislike and share icons are present
    FOR    ${icons}    IN RANGE    5    8    
        Wait For And Verify Element           xpath=(//button[@aria-label='button'])[${icons}]
    END