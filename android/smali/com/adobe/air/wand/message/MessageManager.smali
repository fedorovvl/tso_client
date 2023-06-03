.class public abstract Lcom/adobe/air/wand/message/MessageManager;
.super Ljava/lang/Object;
.source "MessageManager.java"


# static fields
.field protected static final NAME_ARGUMENTS:Ljava/lang/String; = "arguments"

.field protected static final NAME_DATA:Ljava/lang/String; = "data"

.field public static final NAME_ERROR_MESSAGE:Ljava/lang/String; = "message"

.field protected static final NAME_HEADER:Ljava/lang/String; = "header"

.field protected static final NAME_NOTIFICATION:Ljava/lang/String; = "notification"

.field protected static final NAME_RESULT:Ljava/lang/String; = "result"

.field protected static final NAME_STATUS:Ljava/lang/String; = "status"

.field protected static final NAME_TASK_ID:Ljava/lang/String; = "taskID"

.field protected static final NAME_TIMESTAMP:Ljava/lang/String; = "timestamp"

.field protected static final NAME_TITLE:Ljava/lang/String; = "title"

.field protected static final NAME_TYPE:Ljava/lang/String; = "type"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract createDataArray()Lcom/adobe/air/wand/message/MessageDataArray;
.end method

.method public abstract createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;
.end method

.method public createSerializedErrorResponse(Lcom/adobe/air/wand/message/Request;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;
    .param p2, "errorMessage"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 126
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 127
    .local v0, "result":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v1, "message"

    invoke-interface {v0, v1, p2}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 129
    sget-object v1, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual {p0, p1, v1, v0}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Response;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public createSerializedErrorResponse(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "errorMessage"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 111
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 112
    .local v0, "result":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v1, "message"

    invoke-interface {v0, v1, p3}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 114
    sget-object v1, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public createSerializedNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "notification"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 99
    invoke-virtual {p0, p1, p2}, Lcom/adobe/air/wand/message/MessageManager;->createWandNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Notification;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public createSerializedRequest(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Ljava/lang/String;
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "args"    # Lcom/adobe/air/wand/message/MessageDataArray;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 135
    invoke-virtual {p0, p1, p2, p3}, Lcom/adobe/air/wand/message/MessageManager;->createWandRequest(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Lcom/adobe/air/wand/message/Request;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public createSerializedResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;
    .locals 1
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;
    .param p2, "status"    # Lcom/adobe/air/wand/message/Response$Status;
    .param p3, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 93
    invoke-virtual {p0, p1, p2, p3}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Response;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public createSerializedResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Ljava/lang/String;
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .param p4, "status"    # Lcom/adobe/air/wand/message/Response$Status;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 88
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public createSerializedSuccessResponse(Lcom/adobe/air/wand/message/Request;)Ljava/lang/String;
    .locals 2
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 120
    sget-object v0, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Response;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public createSerializedSuccessResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 105
    sget-object v0, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/message/MessageManager;->serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract createWandNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Notification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract createWandRequest(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Lcom/adobe/air/wand/message/Request;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public createWandResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Response;
    .locals 2
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;
    .param p2, "status"    # Lcom/adobe/air/wand/message/Response$Status;
    .param p3, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 81
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Request;->getHeader()Lcom/adobe/air/wand/message/Request$Header;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/wand/message/Request$Header;->getTitle()Ljava/lang/String;

    move-result-object v0

    .line 82
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Request;->getHeader()Lcom/adobe/air/wand/message/Request$Header;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/wand/message/Request$Header;->getTaskID()Ljava/lang/String;

    move-result-object v1

    .line 81
    invoke-virtual {p0, v0, v1, p3, p2}, Lcom/adobe/air/wand/message/MessageManager;->createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;

    move-result-object v0

    return-object v0
.end method

.method public abstract createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract deserializeWandMessage(Ljava/lang/String;)Lcom/adobe/air/wand/message/Message;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method
