package movie.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieInsertController {
	private final String command = "insert.mv"; // 요청 URL 패턴
	private final String getPage = "movieInsertForm"; // GET 요청 시 이동할 페이지
	private final String gotoPage = "redirect:/list.mv"; // POST 요청 후 리디렉션할 페이지

	@Autowired
	private MovieDao movieDao;

	// GET 요청 처리 (추가 버튼 클릭 시)
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insert() {
		return getPage; // 입력 폼 페이지로 이동
	}

	// POST 요청 처리 (인서트 폼의 추가 버튼 클릭 시)
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("movie") @Valid MovieBean movie, BindingResult result) {
		ModelAndView mav = new ModelAndView();

		// kim 팀원 추가
		// kim 팀원 추가
		// kim 팀원 추가
		// kim 팀원 추가
		int cnt = -1;
		cnt = movieDao.insertMovie(movie);
		
		if(cnt != -1) {	
			mav.setViewName(gotoPage);
		}
		else {
			mav.setViewName(getPage);
		}
		return mav;
	}
}
