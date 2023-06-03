.class Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;
.super Landroid/os/AsyncTask;
.source "AndroidGcmRegistrationService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidGcmRegistrationService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "AsyncTaskRunner"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/lang/Integer;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AndroidGcmRegistrationService;


# direct methods
.method private constructor <init>(Lcom/adobe/air/AndroidGcmRegistrationService;)V
    .locals 0

    .prologue
    .line 182
    iput-object p1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/AndroidGcmRegistrationService;Lcom/adobe/air/AndroidGcmRegistrationService$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;
    .param p2, "x1"    # Lcom/adobe/air/AndroidGcmRegistrationService$1;

    .prologue
    .line 182
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;-><init>(Lcom/adobe/air/AndroidGcmRegistrationService;)V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 182
    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->doInBackground([Ljava/lang/Integer;)Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Integer;)Ljava/lang/Void;
    .locals 7
    .param p1, "params"    # [Ljava/lang/Integer;

    .prologue
    const v6, 0x493e0

    .line 190
    const/4 v1, 0x0

    :try_start_0
    aget-object v1, p1, v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    int-to-long v2, v1

    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V

    .line 193
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    invoke-static {v2}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$300(Lcom/adobe/air/AndroidGcmRegistrationService;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    move-result-object v2

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    invoke-static {}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$200()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v2, v3}, Lcom/google/android/gms/gcm/GoogleCloudMessaging;->register([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$102(Lcom/adobe/air/AndroidGcmRegistrationService;Ljava/lang/String;)Ljava/lang/String;

    .line 194
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    invoke-static {v1}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$100(Lcom/adobe/air/AndroidGcmRegistrationService;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    .line 196
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    const v2, 0x493e0

    invoke-static {v1, v2}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$400(Lcom/adobe/air/AndroidGcmRegistrationService;I)V

    .line 209
    :goto_0
    const/4 v1, 0x0

    return-object v1

    .line 200
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    invoke-static {v1}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$500(Lcom/adobe/air/AndroidGcmRegistrationService;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 204
    :catch_0
    move-exception v0

    .line 207
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->this$0:Lcom/adobe/air/AndroidGcmRegistrationService;

    invoke-static {v1, v6}, Lcom/adobe/air/AndroidGcmRegistrationService;->access$400(Lcom/adobe/air/AndroidGcmRegistrationService;I)V

    goto :goto_0
.end method
