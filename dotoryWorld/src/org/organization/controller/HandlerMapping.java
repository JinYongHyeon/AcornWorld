package org.organization.controller;

public class HandlerMapping {
	private static HandlerMapping instance = new HandlerMapping();
	private HandlerMapping() {}
	public static HandlerMapping getInstance () {
		return instance;
	}
	
	public Controller create(String command) {
		Controller controller = null;
	
		return controller;
	}
}
