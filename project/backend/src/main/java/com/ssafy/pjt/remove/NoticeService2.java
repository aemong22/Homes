package com.ssafy.pjt.remove;
//package com.ssafy.pjt.notice.model.service;
//
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ssafy.pjt.notice.model.NoticeDto;
//import com.ssafy.pjt.notice.model.dao.NoticeDao;
//
//public class NoticeService {
//	
//	private static NoticeService noticeService = new NoticeService();
//	private NoticeDao noticeDao;
//	
//	private NoticeService() {
//		noticeDao = NoticeDao.getNoticeDao();
//	}
//	
//	public static NoticeService getNoticeService() {
//		return noticeService;
//	}
//
//	public void write(NoticeDto noticeDto) throws SQLException {
//		int ret=0;
//		int cnt = 1; //member에서 noticeDto.userId와 일치하는 유저를 가져올 것
//		if(cnt>0) {
//			//해당 유저가 있으면 write 처리
//			ret=noticeDao.write(noticeDto);
//		}
//		if(ret==0) {
//			throw new SQLException();
//		}
//	}
//
//	public List<NoticeDto> getlist() throws SQLException {
//		return noticeDao.getlist();
//	}
//
//	public void delete(String noticeNo) throws SQLException {
//		int a =0;
//	
//		int cnt = 1; //member에서 noticeDto.userId와 일치하는 유저를 가져올 것
//		if(cnt>0) {
//			//해당 유저가 있으면 write 처리
//			a=noticeDao.delete(noticeNo);
//		}
//		if(a==0) {
//			throw new SQLException();
//		}
//	}
//
//
//	public NoticeDto getNotice(String noticeNo) throws SQLException {
//		return noticeDao.getNotice(noticeNo);
//	}
//
//	public void modify(NoticeDto noticeDto) throws SQLException {
//		int a =0;
//		
//		int cnt = 1; //member에서 noticeDto.userId와 일치하는 유저를 가져올 것
//		if(cnt>0) {
//			//해당 유저가 있으면 write 처리
//			a=noticeDao.modify(noticeDto);
//		}
//		if(a==0) {
//			throw new SQLException();
//		}
//	}
//
//	//단어에 맞춰 kmp 알고리즘 실행
//	//해당 단어를 포함하는 제목 가져오기
//	public List<NoticeDto> search(String word) throws SQLException {
//		List<NoticeDto> all = noticeDao.getlist();
//		List<NoticeDto> lists = new ArrayList<>();
//		
//		int[] table = makeTable(word);
//		
//		for(NoticeDto notice:all) {
//			if(KMP(notice.getSubject(),word,table))lists.add(notice);
//		}
//		return lists;
//	}
//	
//	//접두사와 접미사가 같은 경우 단어 길이를 배열에 저장
//	public int[] makeTable(String pattern) {
//		int n = pattern.length();
//		int[] table = new int[n];
//		
//		int idx =0;
//		for(int i=1;i<n;i++) {
//			//일치하는 문자가 발생한 경우, 연속적으로 더 일치하지 않으면 idx = table[idx-1]로 돌려줌
//			while(idx>0 && pattern.charAt(i)!=pattern.charAt(idx)) {
//				idx=table[idx-1];
//			}
//			if(pattern.charAt(i)==pattern.charAt(idx)) {
//				idx+=1;
//				table[i]=idx;
//			}
//		}
//		return table;
//	}
//	
//	public boolean KMP(String parent, String pattern, int[] table) {
//		int n1 = parent.length();
//		int n2 = pattern.length();
//		
//		int idx = 0;//현재 대응하는 글자 수
//		for(int i=0;i<n1;i++) {
//			//idx 번 글자와 parent에서 현재 보고 있는 글자가 불일치하면,
//			//현재 대응된 글자의 수를 table[idx-1] 로 돌린다
//			while(idx>0 && parent.charAt(i)!= pattern.charAt(idx)) {
//				idx = table[idx-1];
//			}
//			//글자가 대응할 경우
//			if(parent.charAt(i)==pattern.charAt(idx)) {
//				if(idx==n2-1) {
//					return true;
//				}
//				else idx +=1;
//			}
//		}
//		//찾은 글자가 없으면 false 리턴
//		return false;
//	}
//}
