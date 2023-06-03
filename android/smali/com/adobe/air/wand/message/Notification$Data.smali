.class public Lcom/adobe/air/wand/message/Notification$Data;
.super Lcom/adobe/air/wand/message/Message$Data;
.source "Notification.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Notification;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Data"
.end annotation


# instance fields
.field mNotification:Lcom/adobe/air/wand/message/MessageDataObject;


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/MessageDataObject;)V
    .locals 1
    .param p1, "notification"    # Lcom/adobe/air/wand/message/MessageDataObject;

    .prologue
    .line 37
    invoke-direct {p0}, Lcom/adobe/air/wand/message/Message$Data;-><init>()V

    .line 35
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/message/Notification$Data;->mNotification:Lcom/adobe/air/wand/message/MessageDataObject;

    .line 38
    invoke-virtual {p0, p1}, Lcom/adobe/air/wand/message/Notification$Data;->setNotification(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 39
    return-void
.end method


# virtual methods
.method public getNotification()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/adobe/air/wand/message/Notification$Data;->mNotification:Lcom/adobe/air/wand/message/MessageDataObject;

    return-object v0
.end method

.method public setNotification(Lcom/adobe/air/wand/message/MessageDataObject;)V
    .locals 0
    .param p1, "notification"    # Lcom/adobe/air/wand/message/MessageDataObject;

    .prologue
    .line 46
    iput-object p1, p0, Lcom/adobe/air/wand/message/Notification$Data;->mNotification:Lcom/adobe/air/wand/message/MessageDataObject;

    .line 47
    return-void
.end method
