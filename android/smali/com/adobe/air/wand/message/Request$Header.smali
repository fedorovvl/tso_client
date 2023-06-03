.class public Lcom/adobe/air/wand/message/Request$Header;
.super Lcom/adobe/air/wand/message/Message$Header;
.source "Request.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Request;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Header"
.end annotation


# instance fields
.field protected mTaskID:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "timestamp"    # J

    .prologue
    .line 35
    sget-object v0, Lcom/adobe/air/wand/message/Message$Type;->REQUEST:Lcom/adobe/air/wand/message/Message$Type;

    invoke-direct {p0, p1, v0, p3, p4}, Lcom/adobe/air/wand/message/Message$Header;-><init>(Ljava/lang/String;Lcom/adobe/air/wand/message/Message$Type;J)V

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/adobe/air/wand/message/Request$Header;->mTaskID:Ljava/lang/String;

    .line 36
    iput-object p2, p0, Lcom/adobe/air/wand/message/Request$Header;->mTaskID:Ljava/lang/String;

    .line 37
    return-void
.end method


# virtual methods
.method public getTaskID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/adobe/air/wand/message/Request$Header;->mTaskID:Ljava/lang/String;

    return-object v0
.end method

.method public setTaskID(Ljava/lang/String;)V
    .locals 0
    .param p1, "taskID"    # Ljava/lang/String;

    .prologue
    .line 44
    iput-object p1, p0, Lcom/adobe/air/wand/message/Request$Header;->mTaskID:Ljava/lang/String;

    .line 45
    return-void
.end method
