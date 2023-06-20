*** Settings ***
Library                                     SeleniumLibrary
Resource                                    ../../../Common.robot
Resource                                    ../../../Excel_Activity.robot
Resource                                    ../../../../Resources/Local_Keywords.robot

*** Keywords ***
Check 'Launched and its here!' Banner
    #Verify Launched And It’S Here! Section Visible Or Not        Testcase:92547
    Section Verification                    xpath=(//div[@class="l-layout--max-width"])[5]  Launched and it's here!_Section
    
    #Verify Ui And Content Of "Launched And Its Hered!" Section   Testcase:92548
    Read Data of Launch and its here from Excel
    
    #Scroll Till The Section Is Visible
    Scroll To                xpath=//div[@class="j-card size--xxs card-vertical no-top-padding j-card__shadow shadow-vertical-mg width-100pc"][1]
    
    #Verify The Title Of The Section
    Text Verification                  xpath=//h2[contains(.,'Launched and it’s here!')]    ${Launched}
    
    #Verify The Subtext Of The Section
    Text Verification                  xpath=//div[normalize-space()='One-stop for all things latest.']    ${One_step}
    
    #Verify The Count Of The Images Present
    ${card_counts}=    Get Element Count     xpath=//div[@class="j-card size--xxs card-vertical no-top-padding j-card__shadow shadow-vertical-mg width-100pc"]   
    IF  ${card_counts} != 3
      Fail    msg=Images are more or less
    END
    #Verify The Content Of The Section 
    FOR  ${card}  IN RANGE   0    ${card_counts}
        
        #Verify The Images Present
        Wait For And Verify Element         xpath=(//div[@class="j-card size--xxs card-vertical no-top-padding j-card__shadow shadow-vertical-mg width-100pc"])[${card+1}]

        #Verify The Name Of The Product
        Log To Console                      ${Product_Name[${card}]} 
        Element Text Should Be              xpath=(//h3[@class="j-contentBlock__title j-heading j-text-heading-xs "])[${card+1}]    ${Product_Name[${card}]}
        
        #Verify The Subtext Of The Product Present
        Log To Console                      ${Find_all_the_recently[${card}]} 
        Element Text Should Be              xpath=(//div[@class="j-contentBlock__description j-text-body-s j-color-primary-grey-80"])[${card+1}]    ${Find_all_the_recently[${card}]}
        Wait For And Verify Element         (//button[contains(@aria-label,'button')][normalize-space()='Buy Now'])[${card+1}]
        CSS Verification                    (//button[@class="j-button j-button-size__small primary flex-grow-0 w-auto"])[${card+1}]    background-color    rgba(15, 60, 201, 1)
        # Checking Redirection After Clicking Each Button  Of 'Launched And Its Here!' Banner 
        # Verifying The Url Of Redirection Page & Taking Screenshot        Testcase:92549,92550 
        Redirection On Clicking       xpath=(//button[contains(@class,"j-button j-button-size__small primary flex")])[(${card}+1)]   ${Launched_URL[${card}]}    Launched_Section[${card}]  
        # Site Issue 
        IF    ${card} == 0
        Go Back
        Sleep    200ms                #Sleep Required
        END
    END
