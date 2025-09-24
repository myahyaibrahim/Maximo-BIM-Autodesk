/*
 * IBM Confidential
 * OCO Source Materials
 * 5737-M66, 5900-AAA, 5900-AMG
 * (C) Copyright IBM Corp. 2021, 2024
 * The source code for this program is not published or otherwise divested of
 * its trade secrets, irrespective of what has been deposited with the U.S.
 * Copyright Office.
 */
package psdi.app.bim.viewer.lmv.util;

import static org.junit.Assert.assertEquals;

import static org.junit.Assert.assertTrue;
import org.junit.Test;
import org.w3c.dom.Node;
import org.w3c.dom.svg.SVGDocument;

import psdi.app.bim.viewer.lmv.test.util.SampleTestData;

public class SVGUtilsTest {
	public static final String COPYRIGHT = "(C) Copyright IBM Corp. 2021, 2024 All Rights Reserved.\n";
	
	@Test
	public void testGetSVGDocumentFromString() throws Exception {
		
		SVGDocument svgDocument = SVGUtils.getSVGDocumentFromString(SampleTestData.MARKUP_STRING1);
		
		Node rootNode = svgDocument.getRootElement();
		
		String actualRootElementName = rootNode.getNodeName();
		
		assertEquals("Root Element Name is not expected", "svg", actualRootElementName);
			
	}
	
	@Test
	public void testParseSvgDocumentToString() throws Exception {
		
		SVGDocument svgDocument = SVGUtils.getSVGDocumentFromString(SampleTestData.SAMPLE_GENERATED_MARKUP_STRING);
		
		String actualGeneratedMarkupString = SVGUtils.parseSvgDocumentToString(svgDocument);
		
		assertTrue("Svg string is not expected", actualGeneratedMarkupString.contains("svg"));
		
		assertTrue("Svg string is not expected", actualGeneratedMarkupString.contains("type=\"polyline\""));
		
		assertTrue("Svg string is not expected", actualGeneratedMarkupString.contains("size=\"3.683779480394813 3.8527601551812083\""));
		
		assertTrue("Svg string is not expected", actualGeneratedMarkupString.contains("position=\"-4.992678522301464 9.254983964420218\""));
			
	}

}
