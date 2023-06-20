*** Settings ***
Resource                               ../../../Common.robot
Variables                              ../../../../Tests/Support/Discover_Variables.yaml
Resource                               ../../../Excel_Activity.robot


*** Keywords ***
UI and Content of MyJio Resolving queries just got easier verification

    #92452

    #Scroll till MyJio Resolving queries just got easier verification
    Scroll To                               xpath=//section[@class='j-container bg--secondary-20'] 

    #MyJio Resolving queries just got easier section verification
    Section Verification                    xpath=//section[@class='j-container bg--secondary-20']         ${Resolvingqueries_text[0]}

    #Jio logo
    Wait For And Verify Element                      xpath=//img[@alt='MyJio']
    
    #Myjio Heading
    Text Verification                       xpath=//div[@class='j-contentBlock__title j-heading j-text-heading-xs']    ${Resolvingqueries_text[0]} 
    
    #Resolving queries just got easier  heading
    Text Verification                       xpath=//h2[normalize-space()='Resolving queries just got easier']          ${Resolvingqueries_text[1]} 
    
    #Subtext under heading 
    Text Verification                       xpath=//div[@class='j-color-primary-grey-80 j-contentBlock__description j-text-body-l l-breakpoint--desktop']    ${Resolvingqueries_text[2]} 
    
    #QR code 
    Wait For And Verify Element                      xpath=//img[@alt='Scan the QR code of MyJio app']

