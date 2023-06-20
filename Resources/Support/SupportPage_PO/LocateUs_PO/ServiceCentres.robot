*** Settings ***
Resource                   ../../../Common.robot
Variables                  ../../../../Tests/Support/LocateUs_Variables.yaml
Resource                   ../../../Excel_Activity.robot
Resource                   ../../../Local_Keywords.robot

*** Keywords ***
UI and content of 'service center' page verification
    
    Confirm UI Elements Of Service Center Page Verification
    Locate Us Search bar and Suggestions Verification of Service Centers
    MapView Count and ListView Count Verification of Autofetched locations in Service centers
    Confirm On Clicking Any Tile user is Redirected to Jio Service Center Page Verification
    UI And Content Of 'Jio Service Center Details' Page Verification
    Confirm Redirections of Button on the Jio Service Center Page Verification


    

    
Confirm UI Elements Of Service Center Page Verification


    #92511
    #Verify Service center
    Wait For And Verify Content                            xpath=//*[@id="tab-Service Centers-1"]           ${tabtext}[1]
    Wait For And Click Element                             xpath=//*[@id="tab-Service Centers-1"]
    URL Validation                                         ${locateus_URL}
    Take Page Screenshot                                   Sc_ServiceCenter

    #92512     
    Tab Verification

    #List of Service Center Tiles with basic Details are present
    ${Center_tile}=    Get WebElements                     xpath=//section[@data-testid="storeContainer"]
    ${StoreTiles_Length}=    Get Length    ${Center_tile}
    Log To Console    ${StoreTiles_Length} Centers Found
    FOR    ${CenterTile}     IN     @{Center_tile}
        Scroll To                                      ${CenterTile}
        Wait For And Verify Element                    ${CenterTile}
    END

    #Map View
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']

    #92513
    #Verifying if Search Bar is visible
    Wait For And Verify Element                            xpath=//input[@type="search"]

   
Locate Us Search bar and Suggestions Verification of Service Centers

    
    #92515 

    #click on cross icon to clear auto search suggestions
    Wait For And Click Element                             xpath=//span[@class='input-icon input-icon-suffix clickable']

    #Input location in search bar
    Wait For And Input Text                                xpath=//input[@placeholder='Enter your location here']    Nagpur 

    #Check Whether suggestions container apppears
    Wait For And Verify Element                            xpath=//div[@class='sc-jSMfEi hTAndO']    

    #Verifying location suggestions 
    ${searchbar_location}=    Wait Until Keyword Succeeds    1 min   1 sec            Get Text       xpath=//div[@class="simplebar-content"]    
    Wait For And Verify Content                            xpath=//div[@class="simplebar-content"]          ${searchbar_location}
    

#92516

    #Clicking on the 1st location
    Wait For And Click Element                             xpath=//div[@class='sc-dkzDqf doZewl']//section[@class='j-container l-layout--full']
    #Sleep required
    sleep    2s     #Required and fixed 

    #Verifying service centers tiles
    Wait For And Verify Element                            xpath=//div[@class="simplebar-content"]

    #map view verification
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']

    #service centers count list view 
    ${centers_count}=     Get WebElements                  xpath=(//section[@data-testid="storeContainer"])
    ${centers_listview_count}=       Get Length    ${centers_count}
    Log To Console    ${centers_listview_count} Service Center List View Count


    #Locations Icon count mapview
    ${centers_pins}=    Get WebElements                    xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${centers_pins_Count}=     Get Length     ${centers_pins}
    #${centers_pins_Count}-1 is written because in map view one icon of searched city is added 
    ${centers_pins_Count}=     Evaluate                (${centers_pins_Count}-1)
    Log To Console   ${centers_pins_Count} Service Center Mappins found

    #comparing list view and map view
    IF  ${centers_listview_count} == ${centers_pins_Count}
        Log To Console    success
    #Fails if count does not match 
    ELSE
        Fail
    END


#92517
    FOR  ${ListView_tile_Centers}  IN RANGE    1    4        
        
        ${store_status}=     Get Text                  xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Centers} ] 
        #Text Verification if the center is opened
        IF  "${store_status}" == "OPEN" 
                Text Verification                      xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Centers} ]    OPEN
                #Centers name verification if opened
                Text Verification                      xpath=(//section[@data-testid="storeContainer"])[${ListView_tile_Centers}]    ${center_listview_locations1_text}[${ListView_tile_Centers} ] 
        #Text Verification if the center is closed
        ELSE     
                Text Verification                      xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Centers} ]    CLOSED 
                #Centers name verification if closed
                Text Verification                      xpath=(//section[@data-testid="storeContainer"])[${ListView_tile_Centers} ]    ${center_listview_locations2_text}[${ListView_tile_Centers} ] 
        END 
        #centers working days and timing
        Wait For And Verify Element                    xpath=(//div[@class="listItem_time__9PzyG j-text j-text-body-xs"])[${ListView_tile_Centers}]   
    END
       
#92518
MapView Count and ListView Count Verification of Autofetched locations in Service centers

    #Refresh page for enabling auto fetch location
    Reload Page
   
    #clicking on service centers
    Wait For And Click Element                             xpath=//span[normalize-space()='Service Centers']
    Sleep    2s    #Required and Fixed
    
    #map view verification
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']
    
    #Verify Tile Container
    Wait For And Verify Element                            xpath=//div[@class="simplebar-content"]

    #Verify All Store Tiles
    Wait For And Verify Element                            xpath=//section[@role="button"] 

    #Taking Web Elements of All Store Tiles
    ${Autofetch_centers_list}=       Get WebElements  xpath=//section[@role="button"]  
    ${Autofetch_centers_list_count}=  Get Length       ${Autofetch_centers_list}  
    Log To Console   ${Autofetch_centers_list_count} Autofetch Service center listview

    #Map View   
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']

    #Verifying the Map View appears after autofetching location   
    ${Autofetch_centers_Mappins}=        Get WebElements   xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"] 
    ${Autofetch_centers_Mappins_Count}=   Get Length        ${Autofetch_centers_Mappins} 
    #${Autofetch_centers_Mappins_Count}-1 is written because in map view one icon of searched city is added 
    ${Autofetch_centers_Mappins_Count}=   Evaluate          (${Autofetch_centers_Mappins_Count}-1)  
    Log To Console                                         ${Autofetch_centers_Mappins_Count} Autofetch Service center mapview

    #listview and mapview comparison  
    IF     ${Autofetch_centers_list_count} == ${Autofetch_centers_Mappins_Count}
        Log To Console     success
    ELSE
        Fail
    END

    




#92519        
Confirm On Clicking Any Tile user is Redirected to Jio Service Center Page Verification

    #Click on the first tile
    Wait For And Click Element                         xpath=(//section[@data-testid="storeContainer"])[1]
    URL Validation                                     ${locateus_URL}


    #Verify UI of Service Center Details
    Wait For And Verify Content                            xpath=//div[@class="serviceCenterType"]                            Jio Service Center
    
#92520
UI And Content Of 'Jio Service Center Details' Page Verification
    #Verify if Jio Service Centers title is Visible
    Wait For And Verify Content                            xpath=//div[@class="serviceCenterType"]                            Jio Service Center

    #Back Button
    Wait For And Verify Element                            xpath=//button[@aria-label='button Back']

    #Store Icon 
    Wait For And Verify Element                            xpath=//img[@class='storeDescription_headingImage__oAC_N']

    #Store Image
    Wait For And Verify Element                            xpath=(//img[@alt='store'])

    #Address
    ${Address}=        Get Text                            xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']    
    Wait For And Verify Content                            xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']                    ${Address}

    #Locater Symbol near Store Address
    Wait For And Click Element                             xpath=//img[@alt='marker']

    #Scrolling Down 
    Scroll To                                              xpath=//button[@aria-label='button Get Directions']

    #Verifying Time & Status of a store
    ${Time_Status}=    Get Text                            xpath=//div[@class='storeDescription_timingsContainer__2r0mI']
    Wait For And Verify Content                            xpath=//div[@class='storeDescription_timingsContainer__2r0mI']                      ${Time_Status}

    #Contact Number
    ${nostatus}    Run Keyword And Return Status     Wait For And Verify Element    xpath=//div[@class='storeDescription_numberContainer__3wMgM']
    IF    ${nostatus} == True     
        ${ContactNo}=        Get Text                      xpath=//div[@class='storeDescription_numberContainer__3wMgM']
        Wait For And Verify Content                        xpath=//div[@class='storeDescription_numberContainer__3wMgM']                   ${ContactNo}  
    ELSE
        Log To Console    No Contact Number
    END

    #Get Directions Button
    Wait For And Verify Element                            xpath=//button[@aria-label='button Get Directions']
    Text Verification                                      xpath=//button[@aria-label='button Get Directions']     ${locateus_text}[3]

    #Distance From User to Store
    ${Distance}=        Get Text                           xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']
    Wait For And Verify Content                            xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']                      ${Distance}
    Scroll To                                              xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']

    #SubText below Distance
    Wait For And Verify Content                            xpath=//div[@class="storeDescription_offerText__1VvhP j-text j-text-body-s"]                        ${locateus_text}[2] 

    #Get Jio Sim Button
    Wait For And Verify Element                            xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']
    Text Verification                                      xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']         ${locateus_text}[4]

    #Get JioFiber
    Wait For And Verify Element                            xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']
    Text Verification                                      xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']       ${locateus_text}[5]

    #Map 
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']
    
#92521
Confirm Redirections of Button on the Jio Service Center Page Verification
    #Click on get direction button
    Wait For And Click Element                             xpath=//button[@aria-label='button Get Directions']

    #Click on get Jio SIM
    Wait For And Click Element                             xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']
    Change Tab                                             Get New Jio Sim Card - Best Prepaid and Postpaid Sim Home Delivered
    URL Validation                                         ${LocateUs_GetJioSIM_URL}
    Change Tab                                             Locate Us For Nearest Jio Store, Service Center or Hotspot Online
    Take Page Screenshot                                   Sc_GetJioSIM

    #Click on Get Jio Fiber
    Wait For And Click Element                             xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']
    Change Tab                                             Get Jio Fiber Connection - New WiFi Connection For Home
    URL Validation                                         ${LocateUs_GetJioFiber_URL}
    Change Tab                                             Locate Us For Nearest Jio Store, Service Center or Hotspot Online
    Take Page Screenshot                                   Sc_JioFiber

    #Back button
    Wait For And Click Element                             xpath=//button[@aria-label='button Back']

#92533(part2)
Check List view and Map View are autofetched in Service Centers
    wait for and Click Element                             xpath=//span[normalize-space()='Service Centers'] 
    
    #------------------------List View -------------------------
    Wait For And Verify Element                            xpath=//div[@class="simplebar-content"]
    #verifying whether list view appears after autofetching location
    Wait For And Verify Element                            xpath=//section[@data-testid="storeContainer"]
    ${centerslistviewtiles}=    Get WebElements            xpath=//section[@data-testid="storeContainer"]
    ${centerslistviewtilescount}=    Get Length     ${centerslistviewtiles}
    Log To Console  ${centerslistviewtilescount} Center listview Autofetch
    
    #-------------------Map View -------------------------
    Wait For And Verify Element                            xpath=//div[@aria-label='Map']
    #verifying whether map view appears after autofetching location
    Wait For And Verify Element                            xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${centersmapviewpins}=           Get WebElements       xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${centersmapviewpinscount}=      Get Length         ${centersmapviewpins}
    #${centersmapviewpinscount}-1 is written because in map view one icon of searched city is added 
    ${centersmapviewpinscount}=      Evaluate           (${centersmapviewpinscount}-1)
    Log To Console   ${centersmapviewpinscount} Center Mapview Autofetch


    #comparing list view and map view
    IF  ${centerslistviewtilescount} == ${centersmapviewpinscount}   
        Log To Console    success
    ELSE
        Fail
    END
