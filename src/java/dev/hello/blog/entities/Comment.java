package dev.hello.blog.entities;

public class Comment {

    private int comId;
    private String comText;
    private int pid;
    private int uid;

    public Comment() {
    }

    public Comment(String comText, int pid, int uid) {
        this.comText = comText;
        this.pid = pid;
        this.uid = uid;
    }

    public Comment(int comId, String comText, int pid, int uid) {
        this.comId = comId;
        this.comText = comText;
        this.pid = pid;
        this.uid = uid;
    }

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    public String getComText() {
        return comText;
    }

    public void setComText(String comText) {
        this.comText = comText;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

}
