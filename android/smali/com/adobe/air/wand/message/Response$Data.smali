.class public Lcom/adobe/air/wand/message/Response$Data;
.super Lcom/adobe/air/wand/message/Message$Data;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Response;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Data"
.end annotation


# instance fields
.field protected mResult:Lcom/adobe/air/wand/message/MessageDataObject;


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/MessageDataObject;)V
    .locals 1
    .param p1, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;

    .prologue
    .line 78
    invoke-direct {p0}, Lcom/adobe/air/wand/message/Message$Data;-><init>()V

    .line 76
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/message/Response$Data;->mResult:Lcom/adobe/air/wand/message/MessageDataObject;

    .line 79
    invoke-virtual {p0, p1}, Lcom/adobe/air/wand/message/Response$Data;->setResult(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 80
    return-void
.end method


# virtual methods
.method public getResult()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 83
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response$Data;->mResult:Lcom/adobe/air/wand/message/MessageDataObject;

    return-object v0
.end method

.method public setResult(Lcom/adobe/air/wand/message/MessageDataObject;)V
    .locals 0
    .param p1, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/adobe/air/wand/message/Response$Data;->mResult:Lcom/adobe/air/wand/message/MessageDataObject;

    .line 88
    return-void
.end method
