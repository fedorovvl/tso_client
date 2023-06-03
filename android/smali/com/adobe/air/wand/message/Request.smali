.class public Lcom/adobe/air/wand/message/Request;
.super Lcom/adobe/air/wand/message/Message;
.source "Request.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/message/Request$Data;,
        Lcom/adobe/air/wand/message/Request$Header;
    }
.end annotation


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/Request$Header;Lcom/adobe/air/wand/message/Request$Data;)V
    .locals 0
    .param p1, "header"    # Lcom/adobe/air/wand/message/Request$Header;
    .param p2, "data"    # Lcom/adobe/air/wand/message/Request$Data;

    .prologue
    .line 65
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/wand/message/Message;-><init>(Lcom/adobe/air/wand/message/Message$Header;Lcom/adobe/air/wand/message/Message$Data;)V

    .line 66
    return-void
.end method


# virtual methods
.method public bridge synthetic getData()Lcom/adobe/air/wand/message/Message$Data;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Request;->getData()Lcom/adobe/air/wand/message/Request$Data;

    move-result-object v0

    return-object v0
.end method

.method public getData()Lcom/adobe/air/wand/message/Request$Data;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/wand/message/Request;->mData:Lcom/adobe/air/wand/message/Message$Data;

    check-cast v0, Lcom/adobe/air/wand/message/Request$Data;

    return-object v0
.end method

.method public bridge synthetic getHeader()Lcom/adobe/air/wand/message/Message$Header;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Request;->getHeader()Lcom/adobe/air/wand/message/Request$Header;

    move-result-object v0

    return-object v0
.end method

.method public getHeader()Lcom/adobe/air/wand/message/Request$Header;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/adobe/air/wand/message/Request;->mHeader:Lcom/adobe/air/wand/message/Message$Header;

    check-cast v0, Lcom/adobe/air/wand/message/Request$Header;

    return-object v0
.end method
