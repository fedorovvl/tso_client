.class public Lcom/adobe/air/AndroidAlertDialog;
.super Ljava/lang/Object;
.source "AndroidAlertDialog.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "AndroidAlertDialog"


# instance fields
.field private mAlertDialog:Landroid/app/AlertDialog;

.field private mDialogBuilder:Landroid/app/AlertDialog$Builder;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    iput-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mDialogBuilder:Landroid/app/AlertDialog$Builder;

    .line 12
    iput-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    .line 17
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mDialogBuilder:Landroid/app/AlertDialog$Builder;

    .line 18
    return-void
.end method


# virtual methods
.method public GetAlertDialogBuilder()Landroid/app/AlertDialog$Builder;
    .locals 1

    .prologue
    .line 22
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mDialogBuilder:Landroid/app/AlertDialog$Builder;

    return-object v0
.end method

.method public dismiss()V
    .locals 1

    .prologue
    .line 34
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    .line 35
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 36
    :cond_0
    return-void
.end method

.method public getWindow()Landroid/view/Window;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    .line 41
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 42
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setFullScreen()V
    .locals 3

    .prologue
    .line 47
    iget-object v2, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    if-nez v2, :cond_1

    .line 62
    :cond_0
    :goto_0
    return-void

    .line 50
    :cond_1
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .line 51
    .local v0, "lp":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {p0}, Lcom/adobe/air/AndroidAlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 52
    .local v1, "window":Landroid/view/Window;
    if-eqz v1, :cond_0

    .line 57
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 59
    const/4 v2, -0x1

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 60
    const/4 v2, -0x2

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 61
    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    goto :goto_0
.end method

.method public show()V
    .locals 2

    .prologue
    .line 27
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mDialogBuilder:Landroid/app/AlertDialog$Builder;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    .line 28
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    .line 29
    iget-object v0, p0, Lcom/adobe/air/AndroidAlertDialog;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 30
    return-void
.end method
