package com.snowboardcrud.web;

import com.snowboardcrud.domain.Snowboard;
import com.snowboardcrud.service.SnowboardManager;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/snowboard")
public class SnowboardController {
	
	private SnowboardManager snowboardManager = new SnowboardManager();

	@RequestMapping(value = "/createSnowboard", method = RequestMethod.POST)
	public String processCreateSnowboard(@ModelAttribute("snowboard")
							Snowboard snowboard, BindingResult result) {

		snowboardManager.createSnowboard(snowboard);
		
		return "redirect:manageSnowboard";
	}
	
	@RequestMapping(value = "/deleteSnowboard/{id}")
	public String processDeleteSnowboard(@PathVariable ("id") Long id) {
		
		snowboardManager.deleteSnowboard(id);

		return "redirect:/snowboard/manageSnowboard";
	}
	
	@RequestMapping(value = "/ajaxUpdate/{id}/{fieldModified}/{newValue}", 
			method = RequestMethod.POST)
	public String ajaxUpdate(@PathVariable ("id") Long id, 
			@PathVariable ("fieldModified") String fieldModified, 
			@PathVariable ("newValue") String newValue){
		
		snowboardManager.updateSnowboard(id, fieldModified, newValue);

		return null;
	}
	
	@RequestMapping("/manageSnowboard")
	public ModelAndView showSnowboards() {
		
		ModelAndView modelAndView = new ModelAndView("snowboard/manageSnowboard");
		modelAndView.addObject("command", new Snowboard());
		modelAndView.addObject("snowboardList", snowboardManager.getSnowboardList());
		
		return modelAndView;
		
	}
}
