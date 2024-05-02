package kr.happyjob.study.surveyMgt.domain;

public class LecSurveyPageResolver {
    private LecSearchItem lsc;

    private int totalCnt;
    private final int NAV_SIZE = 5;
    private int totalPage;
    private int page;
    private int beginPage;
    private int endPage;
    private boolean showNext = false;
    private boolean showPrev = false;

    public LecSurveyPageResolver(int totalCnt, LecSearchItem lsc) {
        this.totalCnt = totalCnt;
        this.lsc = lsc;
        doPaging(totalCnt, lsc);
    }

    private void doPaging(int totalCnt, LecSearchItem lsc) {
        this.totalPage = totalCnt / lsc.getPageSize() + (totalCnt % lsc.getPageSize() == 0 ? 0 : 1);
        this.lsc.setPage(Math.min(lsc.getPage(), totalPage));
        this.beginPage = (this.lsc.getPage() - 1) / NAV_SIZE * NAV_SIZE + 1;
        this.endPage = Math.min(this.beginPage + this.NAV_SIZE - 1, totalPage);
        this.showPrev = beginPage != 1;
        this.showNext = endPage != totalPage;
    }

    public void print() {
        System.out.println("현재 페이지 (page) = " + lsc.getPage());
        System.out.print(showPrev ? "PREV " : "");

        for(int i = beginPage; i <= endPage; i++) {
            System.out.print(i + " ");
        }

        System.out.println(showNext ? " NEXT" : "");
    }

    public LecSurveyPageResolver(int totalCnt, Integer page, Integer pageSize) {
        this(totalCnt, new LecSearchItem(page, pageSize));
    }

    public LecSurveyPageResolver(int totalCnt, Integer page) {
        this(totalCnt, new LecSearchItem(page, 20));
    }

    public LecSearchItem getLsc() {
        return lsc;
    }

    public void setLsc(LecSearchItem lsc) {
        this.lsc = lsc;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getNAV_SIZE() {
        return NAV_SIZE;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    @Override
    public String toString() {
        return "LecSurveyPageResolver{" +
                "lsc=" + lsc +
                ", totalCnt=" + totalCnt +
                ", NAV_SIZE=" + NAV_SIZE +
                ", totalPage=" + totalPage +
                ", page=" + page +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showNext=" + showNext +
                ", showPrev=" + showPrev +
                '}';
    }
}