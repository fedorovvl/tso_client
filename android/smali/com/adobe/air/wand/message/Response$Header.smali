.class public Lcom/adobe/air/wand/message/Response$Header;
.super Lcom/adobe/air/wand/message/Message$Header;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Response;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Header"
.end annotation


# instance fields
.field protected mStatus:Lcom/adobe/air/wand/message/Response$Status;

.field protected mTaskID:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;JLcom/adobe/air/wand/message/Response$Status;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "timestamp"    # J
    .param p5, "status"    # Lcom/adobe/air/wand/message/Response$Status;

    .prologue
    .line 53
    sget-object v0, Lcom/adobe/air/wand/message/Message$Type;->RESPONSE:Lcom/adobe/air/wand/message/Message$Type;

    invoke-direct {p0, p1, v0, p3, p4}, Lcom/adobe/air/wand/message/Message$Header;-><init>(Ljava/lang/String;Lcom/adobe/air/wand/message/Message$Type;J)V

    .line 45
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/message/Response$Header;->mStatus:Lcom/adobe/air/wand/message/Response$Status;

    .line 50
    const-string v0, ""

    iput-object v0, p0, Lcom/adobe/air/wand/message/Response$Header;->mTaskID:Ljava/lang/String;

    .line 54
    iput-object p5, p0, Lcom/adobe/air/wand/message/Response$Header;->mStatus:Lcom/adobe/air/wand/message/Response$Status;

    .line 55
    iput-object p2, p0, Lcom/adobe/air/wand/message/Response$Header;->mTaskID:Ljava/lang/String;

    .line 56
    return-void
.end method


# virtual methods
.method public getStatus()Lcom/adobe/air/wand/message/Response$Status;
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response$Header;->mStatus:Lcom/adobe/air/wand/message/Response$Status;

    return-object v0
.end method

.method public getTaskID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 67
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response$Header;->mTaskID:Ljava/lang/String;

    return-object v0
.end method

.method public setStatus(Lcom/adobe/air/wand/message/Response$Status;)V
    .locals 0
    .param p1, "status"    # Lcom/adobe/air/wand/message/Response$Status;

    .prologue
    .line 63
    iput-object p1, p0, Lcom/adobe/air/wand/message/Response$Header;->mStatus:Lcom/adobe/air/wand/message/Response$Status;

    .line 64
    return-void
.end method

.method public setTaskID(Ljava/lang/String;)V
    .locals 0
    .param p1, "taskID"    # Ljava/lang/String;

    .prologue
    .line 71
    iput-object p1, p0, Lcom/adobe/air/wand/message/Response$Header;->mTaskID:Ljava/lang/String;

    .line 72
    return-void
.end method
