.class public Lcom/adobe/air/wand/message/Response;
.super Lcom/adobe/air/wand/message/Message;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/message/Response$Data;,
        Lcom/adobe/air/wand/message/Response$Header;,
        Lcom/adobe/air/wand/message/Response$Status;
    }
.end annotation


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/Response$Header;Lcom/adobe/air/wand/message/Response$Data;)V
    .locals 0
    .param p1, "header"    # Lcom/adobe/air/wand/message/Response$Header;
    .param p2, "data"    # Lcom/adobe/air/wand/message/Response$Data;

    .prologue
    .line 92
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/wand/message/Message;-><init>(Lcom/adobe/air/wand/message/Message$Header;Lcom/adobe/air/wand/message/Message$Data;)V

    .line 93
    return-void
.end method


# virtual methods
.method public bridge synthetic getData()Lcom/adobe/air/wand/message/Message$Data;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Response;->getData()Lcom/adobe/air/wand/message/Response$Data;

    move-result-object v0

    return-object v0
.end method

.method public getData()Lcom/adobe/air/wand/message/Response$Data;
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response;->mData:Lcom/adobe/air/wand/message/Message$Data;

    check-cast v0, Lcom/adobe/air/wand/message/Response$Data;

    return-object v0
.end method

.method public bridge synthetic getHeader()Lcom/adobe/air/wand/message/Message$Header;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Response;->getHeader()Lcom/adobe/air/wand/message/Response$Header;

    move-result-object v0

    return-object v0
.end method

.method public getHeader()Lcom/adobe/air/wand/message/Response$Header;
    .locals 1

    .prologue
    .line 96
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response;->mHeader:Lcom/adobe/air/wand/message/Message$Header;

    check-cast v0, Lcom/adobe/air/wand/message/Response$Header;

    return-object v0
.end method
