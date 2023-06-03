.class Lcom/adobe/air/FileInfo;
.super Ljava/lang/Object;
.source "ApplicationFileManager.java"


# instance fields
.field public mFileSize:J

.field public mIsDirectory:Z

.field public mIsFile:Z


# direct methods
.method constructor <init>(JZZ)V
    .locals 1
    .param p1, "fileSize"    # J
    .param p3, "isFile"    # Z
    .param p4, "isDirectory"    # Z

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-wide p1, p0, Lcom/adobe/air/FileInfo;->mFileSize:J

    .line 50
    iput-boolean p3, p0, Lcom/adobe/air/FileInfo;->mIsFile:Z

    .line 51
    iput-boolean p4, p0, Lcom/adobe/air/FileInfo;->mIsDirectory:Z

    .line 52
    return-void
.end method
