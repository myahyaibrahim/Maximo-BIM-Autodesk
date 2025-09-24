/*
 * IBM Confidential
 * OCO Source Materials
 * 5737-M66, 5900-AAA, 5900-AMG
 * (C) Copyright IBM Corp. 2021, 2024
 * The source code for this program is not published or otherwise divested of
 * its trade secrets, irrespective of what has been deposited with the U.S.
 * Copyright Office.
 */
package psdi.app.bim.viewer.lmv.test.util;


import java.util.ArrayList;
import java.util.List;

import psdi.app.bim.viewer.lmv.DefectView;
import psdi.app.bim.viewer.lmv.DefectViewSet;
import psdi.mbo.MockedMbo;
import psdi.mbo.MockedMboSet;
import psdi.security.UserInfo;
import psdi.security.UserInfoMocker;

public class DefectTestUtil {
	public static final String COPYRIGHT = "(C) Copyright IBM Corp. 2021, 2024 All Rights Reserved.\n";
	
	public static final String RETURNED_SAMPLE_MARKUP_JSON_STRING = "<svg xmlns=\"http://www.w3.org/2000/svg\" contentScriptType=\"text/ecmascript\" zoomAndPan=\"magnify\" layer-order-id=\"markups-svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" baseProfile=\"full\" contentStyleType=\"text/css\" style=\"position:absolute; left:0; top:0; transform:scale(1,-1); -ms-transform:scale(1,-1); -webkit-transform:scale(1,-1); -moz-transform:scale(1,-1); -o-transform:scale(1,-1); transformOrigin:0, 0; -ms-transformOrigin:0, 0; -webkit-transformOrigin:0, 0; -moz-transformOrigin:0, 0; -o-transformOrigin:0, 0; \" version=\"1.1\" width=\"842\" preserveAspectRatio=\"xMidYMid meet\" cursor=\"crosshair\" viewBox=\"-16.715096967145634 -9.637059248988127 28.456351563061354 33.79614170652676\" pointer-events=\"painted\" height=\"1000\"><metadata><markup_document xmlns=\"http://www.w3.org/1999/xhtml\" data-model-version=\"4\"/></metadata><g pointer-events=\"stroke\" cursor=\"inherit\"><metadata><markup_element xmlns=\"http://www.w3.org/1999/xhtml\" type=\"rectangle\" fill-opacity=\"0\" size=\"2.669895218365969 2.027768502235155\" position=\"-12.674628983682897 10.30266435743572\" fill-color=\"#ff0000\" stroke-color=\"#ff0000\" stroke-width=\"0.033796141711150085\" stroke-opacity=\"1\" rotation=\"0\"/></metadata><path fill=\"none\" id=\"markup\" d=\"M -1.3180495383274096 -0.9969861802620024 l 2.636099076654819 0 l 0 1.9939723605240047 l -2.636099076654819 0 z\" stroke-width=\"0.033796141711150085\" transform=\"translate( -12.674628983682897 , 10.30266435743572 ) rotate( 0 )\" stroke=\"rgba(255,0,0,1)\"/></g><g pointer-events=\"stroke\" cursor=\"inherit\"><metadata><markup_element xmlns=\"http://www.w3.org/1999/xhtml\" type=\"polyline\" fill-opacity=\"0\" size=\"3.683779480394813 3.8527601551812083\" position=\"-4.992678522301464 9.254983964420218\" locations=\"1.8418897401974075 1.9263800775906041 -1.8418897401974057 -0.03379614225499061 1.1659668983705416 -1.9263800775906041\" fill-color=\"#ff0000\" stroke-color=\"#ff0000\" stroke-width=\"0.033796141711150085\" stroke-opacity=\"1\" rotation=\"0\"/></metadata><path fill=\"none\" id=\"markup\" d=\"M 1.8418897401974075 1.9263800775906041 l -3.683779480394813 -1.9601762198455948 l 3.0078566385679473 -1.8925839353356135 z\" stroke-width=\"0.033796141711150085\" transform=\"translate( -4.992678522301464 , 9.254983964420218 ) rotate( 0 )\" stroke=\"rgba(255,0,0,1)\"/></g><g pointer-events=\"stroke\" cursor=\"inherit\"><metadata><markup_element xmlns=\"http://www.w3.org/1999/xhtml\" type=\"ellipse\" fill-opacity=\"0\" size=\"1.9263800941605833 1.7236032269556407\" position=\"-7.471852131614063 10.251970144901954\" fill-color=\"#ff0000\" stroke-color=\"#ff0000\" stroke-width=\"0.033796141711150085\" stroke-opacity=\"1\" rotation=\"0\"/></metadata><path fill=\"none\" d=\"M -0.9462919762247166 0 a 0.9462919762247166 0.8449035426222453 0 1 1 1.8925839524494332 0 a 0.9462919762247166 0.8449035426222453 0 1 1 -1.8925839524494332 0 z\" stroke-width=\"0.033796141711150085\" id=\"markup\" transform=\"translate( -7.471852131614063 , 10.251970144901954 ) rotate( 0 )\" stroke=\"rgba(255,0,0,1)\"/></g></svg>";
	
	public static MockedMboSet createMockedDefectMboSet() {

		// mock out the locale and user info
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);
		
		MockedMbo defectMbo1 = createDefectMockedMbo(userInfo, SampleTestData.MARKUP_STRING1, SampleTestData.TICKET_UID1);
		
		MockedMbo defectMbo2 = createDefectMockedMbo(userInfo, SampleTestData.MARKUP_STRING2, SampleTestData.TICKET_UID2);
		
		MockedMbo defectMbo3 = createDefectMockedMbo(userInfo, SampleTestData.MARKUP_STRING3, SampleTestData.TICKET_UID3);

		MockedMboSet markupList = new MockedMboSet(DefectViewSet.class, userInfo);
		List<MockedMbo> mockedMboList = new ArrayList<MockedMbo>();
		mockedMboList.add(defectMbo1);
		mockedMboList.add(defectMbo2);
		mockedMboList.add(defectMbo3);
		markupList.setMboList(mockedMboList);
		
		return markupList;
	}
	
	private static MockedMbo createDefectMockedMbo(UserInfo userInfo, String markup, int ticketUid) {
		MockedMbo mockedDefectMbo = new MockedMbo(DefectView.class, userInfo);
		mockedDefectMbo.setValue(TestConstants.ATTRIBUTE_NAME_MARKUP, markup);
		mockedDefectMbo.setValue(TestConstants.ATTRIBUTE_NAME_TICKETUID, ticketUid);
		return mockedDefectMbo;
	}
	
	public static List<String> createTestSampleMarkupString() {
		List<String> markupList = new ArrayList<String>();
		markupList.add(SampleTestData.MARKUP_STRING1);
		markupList.add(SampleTestData.MARKUP_STRING2);
		markupList.add(SampleTestData.MARKUP_STRING3);
		return markupList;
	}

}
