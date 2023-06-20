*** Settings ***
Resource                   ../../../Excel_Activity.robot
Resource                   ../../../Common.robot
Variables                  ../../../../Tests/Support/LocateUs_Variables.yaml
Resource                   ../../../Local_Keywords.robot
 
*** Keywords ***

UI and Content of 'Hotspots' Page Verification
    Confirm UI Elements of Hotspot Page Verification
    Locate Us Search bar and Suggestions Verification of Hotspot
    MapView Count and ListView Count Verification of Autofetched locations in Hotspot
    Confirm On Clicking Any Tile user is Redirected to Hotspot Page Verification
    UI and Content of 'Hotspot details' Page
    Confirm Redirections of Button on the Jio Hotspot Page Verification 

    

Confirm UI Elements of Hotspot Page Verification

    
    #92522
    #Verification of Stores from the top Nav bar
    Wait For And Click Element                         xpath=//span[normalize-space()='Hotspots']
    Wait For And Verify Content                        xpath=//span[normalize-space()='Hotspots']    ${tabtext}[2]
    URL Validation                                     ${locateus_URL}
    Take Page Screenshot                               Support_Hotspot_Redirection


    #92523
    Tab Verification    #Covert locators to args
    #Verifying the Hotspots Container
    ${HotspotTiles}=    Get WebElements                xpath=//section[@data-testid="storeContainer"]
    ${HotspotTiles_Length}=    Get Length    ${HotspotTiles}
    Log To Console    ${HotspotTiles_Length} Hotspots found
    FOR     ${Hotspot_Tile}    IN      @{HotspotTiles}
        Scroll To                                      ${Hotspot_Tile}
        Wait For And Verify Element                    ${Hotspot_Tile}
    END

    #Verify Map
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']

    #Footer Verification
    Wait For And Verify Element                        xpath=(//section[@class="j-container l-layout--max-width"])[2]

    #92524 - Verifying if Search Bar is visible
    Wait For And Verify Element                        xpath=//input[@type="search"]


    
#92526 TestCase
Locate Us Search bar and Suggestions Verification of Hotspot

    #Click on Cross button
    Wait For And Click Element                         xpath=//span[@class='input-icon input-icon-suffix clickable']

    #Enter Location
    Wait For And Input Text                            xpath=//input[@placeholder='Enter your location here']    Ambivali
    Sleep    500ms    #Required and Fixed  

    #Check Whether suggestions container apppears
    Wait For And Verify Element                        xpath=//div[@class='sc-jSMfEi hTAndO']  


#92527  
    
    #Clicks on 1st suggested location
    Wait For And Click Element                         xpath=//div[@class='sc-dkzDqf doZewl']//section[@class='j-container l-layout--full']
    Sleep    2s    #Required and Fixed

#92527,92528 TestCase
    #Verifying Location pin on Map
    ${Hotspot_MapPins}=    Get WebElements             xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${Hotspot_MapPins_Count}=     Get Length     ${Hotspot_MapPins}
    #${Hotspot_MapPins_Count}-1 is written because in map view one icon of searched city is added 
    ${Hotspot_MapPins_Count}=     Evaluate                (${Hotspot_MapPins_Count}-1)

    Log To Console   ${Hotspot_MapPins_Count} Hotspot Mappins found



    #Locations List view
    ${Hotspot_List}=     Get WebElements              xpath=(//section[@data-testid="storeContainer"])
    ${Hotspot_List_Count}=       Get Length    ${Hotspot_List}
    Log To Console    ${Hotspot_List_Count} Hotspot locations listed

    #Check whether Map view elements and List view elements are same
    IF    ${Hotspot_MapPins_Count} == ${Hotspot_List_Count}
        Log To Console    pass
    ELSE
        Fail
    END


    #Check list view and verify each tiles
    FOR  ${ListView_tile_Hotspot}  IN RANGE    0    4      
        #Name of Hotspot content Verification
        Text Verification                            xpath=(//div[@class="listItem_address__1y0IR,listItem_mt10__1m8tj j-text j-text-body-s-bold"])[${ListView_tile_Hotspot+1}]      ${hotspot_listview_locations_text}[${ListView_tile_Hotspot}]

       
        #Hotspot icon verification
        Wait For And Verify Element                  xpath=(//*[name()='path' and contains(@d,'M4 11a8 8 ')])[${ListView_tile_Hotspot+1}]

        
    END

    
#92529
MapView Count and ListView Count Verification of Autofetched locations in Hotspot 
    #Refresh page for enabling auto fetch location
    Reload Page

    Wait For And Click Element                          xpath=//span[normalize-space()='Hotspots']

    Sleep    2s     #required and fixed
    #Verifying whether list view appears after autofetching location  
    Wait For And Verify Element                         xpath=//div[@class="simplebar-content"]

    #Checking the number of Stores in List View
    ${Autofetch_Hotspot_list}=       Get WebElements    xpath=//section[@role="button"] 
    ${Autofetch_Hotspot_list_count}=  Get Length           ${Autofetch_Hotspot_list} 
    Log To Console    ${Autofetch_Hotspot_list_count} Autofetch Hotspot listview

    

    #Verifying whether map view appears after autofetching location  
    Wait For And Verify Element                                xpath=//div[@aria-label='Map']

    #Checking the number of pins in Map View
    ${Autofetch_Hotspot_Mappins}=         Get WebElements      xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]   
    ${Autofetch_Hotspot_Mappins_Count}=    Get Length            ${Autofetch_Hotspot_Mappins} 
    #${Autofetch_Hotspot_Mappins_Count}-1 is written because in map view one icon of searched city is added 
    ${Autofetch_Hotspot_Mappins_Count}=    Evaluate             (${Autofetch_Hotspot_Mappins_Count}-1)  
    Log To Console    ${Autofetch_Hotspot_Mappins_Count} Autofetch Hotspot mapview

    #Listview and mapview comparison
    IF     ${Autofetch_Hotspot_list_count} == ${Autofetch_Hotspot_Mappins_Count}
        Log To Console     success
    ELSE
        Fail
    END


Confirm On Clicking Any Tile user is Redirected to Hotspot Page Verification
    #92530

    Sleep    200ms

    #Click on 1st Tile
    Wait For And Click Element                         xpath=(//section[@role="button"])[1]
    URL Validation                                     ${locateus_URL}
    Take Page Screenshot                               SC_hotspot Tile


# Testcase : 92531
UI and Content of 'Hotspot details' Page

    #Heading of the hotspot page
    Text Verification                                       xpath=//div[@class='hotspotType']                ${locateus_text}[1]

    #back button
    Wait For And Verify Element                             xpath=//button[@aria-label='button Back']

    #hotspot icon
    Wait For And Verify Element                             xpath=//img[@class='storeDescription_headingImage__oAC_N']

    #Store Image
    Wait For And Verify Element                             xpath=//img[@alt='store']

    #Hotspot area
    Wait For And Verify Element                        xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']
    ${fullAddress} =    Get Text                       xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']    
    Text Verification                                  xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']            ${fullAddress}

    #locator symbol
    Wait For And Verify Element                             xpath=//button[@data-testid="pinnedLocation"]

    #get Directions button
    Wait For And Verify Element                             xpath=//button[@aria-label='button Get Directions']
    Text Verification                                       xpath=//button[@aria-label='button Get Directions']    ${locateus_text}[3]
    Scroll To                                               xpath=//a[@href="https://www.jio.com/en-in/jio-postpaid-prepaid-home-delivery-book-appointment.html?utm_source=StoreLocator&utm_medium=Banner"]

    #distance in km
    Wait For And Verify Element                             xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']
    ${distance}=    Get Text                                       xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']
    Wait For And Verify Content                             xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']          ${distance}

    #relevant text
    Text Verification                                       xpath=//div[@class='storeDescription_offerText__1VvhP j-text j-text-body-s']    ${locateus_text[2]}

    #get jiosim link
    Wait For And Verify Element                             xpath=//a[@href="https://www.jio.com/en-in/jio-postpaid-prepaid-home-delivery-book-appointment.html?utm_source=StoreLocator&utm_medium=Banner"]
    Text Verification                                       xpath=//a[@href="https://www.jio.com/en-in/jio-postpaid-prepaid-home-delivery-book-appointment.html?utm_source=StoreLocator&utm_medium=Banner"]    ${locateus_text}[4]

    #get jiofiber link
    Wait For And Verify Element                             xpath=//a[@href="https://www.jio.com/registration?utm_source=StoreLocator&utm_medium=Banner"]
    Text Verification                                       xpath=//a[@href="https://www.jio.com/registration?utm_source=StoreLocator&utm_medium=Banner"]  ${locateus_text}[5]
      
#92532
Confirm Redirections of Button on the Jio Hotspot Page Verification

    #Redirection to Google maps    
    Wait For And Click Element                         xpath=//button[@aria-label='button Get Directions']

    #Click and Get JioSIM link     
    Wait For And Click Element                         xpath=//a[@href="https://www.jio.com/en-in/jio-postpaid-prepaid-home-delivery-book-appointment.html?utm_source=StoreLocator&utm_medium=Banner"]
    Change Tab                                         Get New Jio Sim Card - Best Prepaid and Postpaid Sim Home Delivered 
    Take Page Screenshot                               SC_GetJioSim
    URL Validation                                     ${LocateUs_GetJioSIM_URL}
    Change Tab                                         Locate Us For Nearest Jio Store, Service Center or Hotspot Online

    #Click and Get JioFiber link    
    Wait For And Click Element                         xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']
    Change Tab                                         Get Jio Fiber Connection - New WiFi Connection For Home
    Take Page Screenshot                               SC_GetJioFiber
    URL Validation                                     ${LocateUs_GetJioFiber_URL}
    Change Tab                                         Locate Us For Nearest Jio Store, Service Center or Hotspot Online

    #Back button
    Wait For And Click Element                         xpath=//button[@aria-label='button Back']
     
#92533 (part 3)

Check List view and Map View are autofetched in Hotspots
    wait for and Click Element                         xpath=//button[@id='tab-Hotspots-2']
    
    #------------------------List View -------------------------
    Wait For And Verify Element                        xpath=//div[@class="simplebar-content"]
    #verifying whether list view appears after autofetching location
    Wait For And Verify Element                        xpath=//section[@data-testid="storeContainer"]
    ${hotspotlistviewtiles}=         Get WebElements   xpath=//section[@data-testid="storeContainer"]
    ${hotspotlistviewtilescount}=    Get Length         ${hotspotlistviewtiles}
    Log To Console    ${hotspotlistviewtilescount} Hotspot listview Autofetch
    
    #-------------------Map View -------------------------
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']
    #verifying whether map view appears after autofetching location
    Wait For And Verify Element                        xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${hotspotmapviewpins}=           Get WebElements   xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${hotspotmapviewpinscount}=      Get Length         ${hotspotmapviewpins}
    #${hotspotmapviewpinscount}-1 is written because in map view one icon of searched city is added 
    ${hotspotmapviewpinscount}=      Evaluate           (${hotspotmapviewpinscount}-1)
    Log To Console    ${hotspotmapviewpinscount} Hotspot Mapview Autofetch

    #----------listview and mapview comparison---------------
    IF     ${hotspotlistviewtilescount} == ${hotspotmapviewpinscount}
        Log To Console    success
    ELSE
        Fail
    END