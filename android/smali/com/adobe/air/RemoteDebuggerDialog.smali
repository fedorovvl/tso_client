.class public final Lcom/adobe/air/RemoteDebuggerDialog;
.super Ljava/lang/Object;
.source "RemoteDebuggerDialog.java"


# instance fields
.field private final mActivity:Landroid/app/Activity;


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 0
    .param p1, "act"    # Landroid/app/Activity;

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerDialog;->mActivity:Landroid/app/Activity;

    .line 42
    return-void
.end method


# virtual methods
.method public createAndShowDialog(Ljava/lang/String;)V
    .locals 10
    .param p1, "hostOrIPaddress"    # Ljava/lang/String;

    .prologue
    const/16 v9, 0x14

    const/4 v8, -0x1

    .line 46
    new-instance v2, Landroid/widget/LinearLayout;

    iget-object v5, p0, Lcom/adobe/air/RemoteDebuggerDialog;->mActivity:Landroid/app/Activity;

    invoke-direct {v2, v5}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 47
    .local v2, "pLayout":Landroid/widget/LinearLayout;
    new-instance v5, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v5, v8, v8}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 48
    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 50
    new-instance v3, Landroid/widget/TextView;

    iget-object v5, p0, Lcom/adobe/air/RemoteDebuggerDialog;->mActivity:Landroid/app/Activity;

    invoke-direct {v3, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 51
    .local v3, "pText":Landroid/widget/TextView;
    const-string v0, ""

    .line 52
    .local v0, "helpString":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 53
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-static {v6}, Lcom/adobe/air/AndroidLocale;->GetLocalizedString(Lcom/adobe/air/AndroidLocale$STRING_ID;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "%1"

    invoke-virtual {v6, v7, p1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 55
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ENTERIP_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-static {v6}, Lcom/adobe/air/AndroidLocale;->GetLocalizedString(Lcom/adobe/air/AndroidLocale$STRING_ID;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 57
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 59
    new-instance v5, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v5, v8, v8}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 60
    invoke-virtual {v3, v9, v9, v9, v9}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 62
    new-instance v4, Landroid/widget/EditText;

    iget-object v5, p0, Lcom/adobe/air/RemoteDebuggerDialog;->mActivity:Landroid/app/Activity;

    invoke-direct {v4, v5}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 63
    .local v4, "pTextinput":Landroid/widget/EditText;
    new-instance v5, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v5, v8, v8}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 64
    const/16 v5, 0x1e

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setHeight(I)V

    .line 65
    const/16 v5, 0x19

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setWidth(I)V

    .line 67
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 68
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 70
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v5, p0, Lcom/adobe/air/RemoteDebuggerDialog;->mActivity:Landroid/app/Activity;

    invoke-direct {v1, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 71
    .local v1, "mInputDialog":Landroid/app/AlertDialog$Builder;
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 72
    const-string v5, "Adobe AIR"

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 74
    sget-object v5, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_OK:Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-static {v5}, Lcom/adobe/air/AndroidLocale;->GetLocalizedString(Lcom/adobe/air/AndroidLocale$STRING_ID;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/adobe/air/RemoteDebuggerDialog$1;

    invoke-direct {v6, p0, v4}, Lcom/adobe/air/RemoteDebuggerDialog$1;-><init>(Lcom/adobe/air/RemoteDebuggerDialog;Landroid/widget/EditText;)V

    invoke-virtual {v1, v5, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 83
    sget-object v5, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CANCEL:Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-static {v5}, Lcom/adobe/air/AndroidLocale;->GetLocalizedString(Lcom/adobe/air/AndroidLocale$STRING_ID;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/adobe/air/RemoteDebuggerDialog$2;

    invoke-direct {v6, p0}, Lcom/adobe/air/RemoteDebuggerDialog$2;-><init>(Lcom/adobe/air/RemoteDebuggerDialog;)V

    invoke-virtual {v1, v5, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 91
    new-instance v5, Lcom/adobe/air/RemoteDebuggerDialog$3;

    invoke-direct {v5, p0}, Lcom/adobe/air/RemoteDebuggerDialog$3;-><init>(Lcom/adobe/air/RemoteDebuggerDialog;)V

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    .line 100
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 101
    return-void
.end method

.method public gotResultFromDialog(ZLjava/lang/String;)V
    .locals 1
    .param p1, "button"    # Z
    .param p2, "ipOrHost"    # Ljava/lang/String;

    .prologue
    .line 105
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 106
    .local v0, "actWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    invoke-virtual {v0, p1, p2}, Lcom/adobe/air/AndroidActivityWrapper;->gotResultFromDialog(ZLjava/lang/String;)V

    .line 107
    return-void
.end method
