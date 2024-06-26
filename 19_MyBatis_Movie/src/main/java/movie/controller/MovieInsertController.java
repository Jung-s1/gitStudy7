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
	private final String command = "insert.mv"; // ��û URL ����
	private final String getPage = "movieInsertForm"; // GET ��û �� �̵��� ������
	private final String gotoPage = "redirect:/list.mv"; // POST ��û �� ���𷺼��� ������

	@Autowired
	private MovieDao movieDao;

	// GET ��û ó�� (�߰� ��ư Ŭ�� ��)
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insert() {
		return getPage; // �Է� �� �������� �̵�
	}

	// POST ��û ó�� (�μ�Ʈ ���� �߰� ��ư Ŭ�� ��)
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("movie") @Valid MovieBean movie, BindingResult result) {
		ModelAndView mav = new ModelAndView();

		// kim ���� �߰�
		// kim ���� �߰�
		// kim ���� �߰�
		// kim ���� �߰�
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
