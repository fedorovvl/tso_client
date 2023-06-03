.class public Lcom/adobe/air/RemoteDebuggerListenerDialog;
.super Landroid/app/Activity;
.source "RemoteDebuggerListenerDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;
    }
.end annotation


# instance fields
.field private final LOG_TAG:Ljava/lang/String;

.field private count:I

.field private debuggerPort:I

.field private mActivity:Landroid/app/Activity;

.field private mCheckAgain:Ljava/lang/Runnable;

.field private mHandler:Landroid/os/Handler;

.field private mReceiver:Landroid/content/BroadcastReceiver;

.field private mWaitDialog:Landroid/app/AlertDialog;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 47
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 234
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->debuggerPort:I

    .line 235
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->count:I

    .line 236
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mHandler:Landroid/os/Handler;

    .line 237
    iput-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    .line 238
    iput-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mCheckAgain:Ljava/lang/Runnable;

    .line 239
    iput-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mActivity:Landroid/app/Activity;

    .line 240
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->LOG_TAG:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/RemoteDebuggerListenerDialog;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->debuggerPort:I

    return v0
.end method

.method static synthetic access$100(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->dismissDialog()V

    return-void
.end method

.method static synthetic access$200(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Ljava/lang/Runnable;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mCheckAgain:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$300(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$400(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->closeListeningDebuggerSocket()V

    return-void
.end method

.method static synthetic access$500(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/content/BroadcastReceiver;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    return-object v0
.end method

.method static synthetic access$502(Lcom/adobe/air/RemoteDebuggerListenerDialog;Landroid/content/BroadcastReceiver;)Landroid/content/BroadcastReceiver;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;
    .param p1, "x1"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    return-object p1
.end method

.method static synthetic access$600(Lcom/adobe/air/RemoteDebuggerListenerDialog;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->count:I

    return v0
.end method

.method static synthetic access$608(Lcom/adobe/air/RemoteDebuggerListenerDialog;)I
    .locals 2
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->count:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->count:I

    return v0
.end method

.method static synthetic access$700(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/app/AlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$702(Lcom/adobe/air/RemoteDebuggerListenerDialog;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;
    .param p1, "x1"    # Landroid/app/AlertDialog;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    return-object p1
.end method

.method static synthetic access$800(Lcom/adobe/air/RemoteDebuggerListenerDialog;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;
    .param p1, "x1"    # Ljava/lang/CharSequence;
    .param p2, "x2"    # Ljava/lang/CharSequence;
    .param p3, "x3"    # Ljava/lang/CharSequence;
    .param p4, "x4"    # Landroid/content/DialogInterface$OnClickListener;
    .param p5, "x5"    # Landroid/content/DialogInterface$OnKeyListener;

    .prologue
    .line 47
    invoke-direct/range {p0 .. p5}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->createDialog(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog;

    move-result-object v0

    return-object v0
.end method

.method private closeListeningDebuggerSocket()V
    .locals 4

    .prologue
    .line 185
    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$5;

    invoke-direct {v0, p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog$5;-><init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    .line 197
    .local v0, "debuggerStopTask":Landroid/os/AsyncTask;, "Landroid/os/AsyncTask<Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;>;"
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Integer;

    const/4 v2, 0x0

    iget v3, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->debuggerPort:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 198
    return-void
.end method

.method private createDialog(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog;
    .locals 3
    .param p1, "title"    # Ljava/lang/CharSequence;
    .param p2, "message"    # Ljava/lang/CharSequence;
    .param p3, "positiveButtonText"    # Ljava/lang/CharSequence;
    .param p4, "positiveClickListener"    # Landroid/content/DialogInterface$OnClickListener;
    .param p5, "keyListener"    # Landroid/content/DialogInterface$OnKeyListener;

    .prologue
    .line 174
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mActivity:Landroid/app/Activity;

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 175
    .local v0, "dialog":Landroid/app/AlertDialog;
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 176
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 177
    const/4 v1, -0x1

    invoke-virtual {v0, v1, p3, p4}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 178
    invoke-virtual {v0, p5}, Landroid/app/AlertDialog;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)V

    .line 179
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 180
    return-object v0
.end method

.method private dismissDialog()V
    .locals 2

    .prologue
    .line 202
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    .line 203
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->cancel()V

    .line 205
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_1

    .line 206
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 208
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    .line 210
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mCheckAgain:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 211
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    .line 212
    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 13
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v12, 0x0

    .line 57
    sget v0, Lcom/adobe/air/R$string;->IDA_APP_WAITING_DEBUGGER_WARNING:I

    invoke-virtual {p0, v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 58
    .local v8, "dialogMessage":Ljava/lang/String;
    sget v0, Lcom/adobe/air/R$string;->IDA_APP_DEBUGGER_TIMEOUT_INFO:I

    invoke-virtual {p0, v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getString(I)Ljava/lang/String;

    move-result-object v11

    .line 60
    .local v11, "timeOutMessage":Ljava/lang/String;
    iput-object p0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mActivity:Landroid/app/Activity;

    .line 61
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 63
    const/16 v6, 0x1f00

    .line 64
    .local v6, "DEFAULT_LISTEN_PORT":I
    const/16 v7, 0x3c

    .line 66
    .local v7, "MAX_WAIT_TIME":I
    invoke-virtual {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v9

    .line 67
    .local v9, "extras":Landroid/os/Bundle;
    if-eqz v9, :cond_0

    const-string v0, "debuggerPort"

    invoke-virtual {v9, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    :goto_0
    iput v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->debuggerPort:I

    .line 69
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    .line 70
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/16 v1, 0x3c

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v0, v12

    invoke-static {v8, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 71
    .local v2, "message":Ljava/lang/String;
    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;

    invoke-direct {v0, p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;-><init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    .line 87
    new-instance v10, Landroid/content/IntentFilter;

    const-string v0, "android.intent.action.MAIN"

    invoke-direct {v10, v0}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 88
    .local v10, "filter":Landroid/content/IntentFilter;
    const-string v0, "RemoteDebuggerListenerDialogClose"

    invoke-virtual {v10, v0}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 89
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0, v10}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 91
    sget v0, Lcom/adobe/air/R$string;->IDA_APP_WAITING_DEBUGGER_TITLE:I

    invoke-virtual {p0, v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget v0, Lcom/adobe/air/R$string;->button_cancel:I

    .line 93
    invoke-virtual {p0, v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;

    invoke-direct {v4, p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;-><init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    new-instance v5, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;

    invoke-direct {v5, p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;-><init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    move-object v0, p0

    .line 91
    invoke-direct/range {v0 .. v5}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->createDialog(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    .line 119
    iput v12, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->count:I

    .line 121
    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    invoke-direct {v0, p0, v8, v11}, Lcom/adobe/air/RemoteDebuggerListenerDialog$4;-><init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mCheckAgain:Ljava/lang/Runnable;

    .line 168
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mCheckAgain:Ljava/lang/Runnable;

    const-wide/16 v4, 0x3e8

    invoke-virtual {v0, v1, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 169
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog;->mWaitDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 170
    return-void

    .line 67
    .end local v2    # "message":Ljava/lang/String;
    .end local v10    # "filter":Landroid/content/IntentFilter;
    :cond_0
    const/16 v0, 0x1f00

    goto :goto_0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 218
    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    .line 219
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->closeListeningDebuggerSocket()V

    .line 220
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->dismissDialog()V

    .line 223
    :cond_0
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onStop()V
    .locals 0

    .prologue
    .line 229
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->closeListeningDebuggerSocket()V

    .line 230
    invoke-direct {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->dismissDialog()V

    .line 231
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 232
    return-void
.end method
