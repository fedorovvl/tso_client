.class public Lcom/adobe/air/wand/message/Notification;
.super Lcom/adobe/air/wand/message/Message;
.source "Notification.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/message/Notification$Data;,
        Lcom/adobe/air/wand/message/Notification$Header;
    }
.end annotation


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/Notification$Header;Lcom/adobe/air/wand/message/Notification$Data;)V
    .locals 0
    .param p1, "header"    # Lcom/adobe/air/wand/message/Notification$Header;
    .param p2, "data"    # Lcom/adobe/air/wand/message/Notification$Data;

    .prologue
    .line 51
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/wand/message/Message;-><init>(Lcom/adobe/air/wand/message/Message$Header;Lcom/adobe/air/wand/message/Message$Data;)V

    .line 52
    return-void
.end method


# virtual methods
.method public bridge synthetic getData()Lcom/adobe/air/wand/message/Message$Data;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v0

    return-object v0
.end method

.method public getData()Lcom/adobe/air/wand/message/Notification$Data;
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/adobe/air/wand/message/Notification;->mData:Lcom/adobe/air/wand/message/Message$Data;

    check-cast v0, Lcom/adobe/air/wand/message/Notification$Data;

    return-object v0
.end method

.method public bridge synthetic getHeader()Lcom/adobe/air/wand/message/Message$Header;
    .locals 1

    .prologue
    .line 25
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Notification;->getHeader()Lcom/adobe/air/wand/message/Notification$Header;

    move-result-object v0

    return-object v0
.end method

.method public getHeader()Lcom/adobe/air/wand/message/Notification$Header;
    .locals 1

    .prologue
    .line 55
    iget-object v0, p0, Lcom/adobe/air/wand/message/Notification;->mHeader:Lcom/adobe/air/wand/message/Message$Header;

    check-cast v0, Lcom/adobe/air/wand/message/Notification$Header;

    return-object v0
.end method
