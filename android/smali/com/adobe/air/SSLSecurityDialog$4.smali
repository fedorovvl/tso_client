.class Lcom/adobe/air/SSLSecurityDialog$4;
.super Ljava/lang/Object;
.source "SSLSecurityDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnKeyListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/SSLSecurityDialog;->ShowSSLDialog(Ljava/lang/String;[BLandroid/net/http/SslCertificate;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/SSLSecurityDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/SSLSecurityDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/SSLSecurityDialog;

    .prologue
    .line 152
    iput-object p1, p0, Lcom/adobe/air/SSLSecurityDialog$4;->this$0:Lcom/adobe/air/SSLSecurityDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/content/DialogInterface;ILandroid/view/KeyEvent;)Z
    .locals 2
    .param p1, "arg0"    # Landroid/content/DialogInterface;
    .param p2, "arg1"    # I
    .param p3, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 155
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    .line 157
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog$4;->this$0:Lcom/adobe/air/SSLSecurityDialog;

    const-string v1, "none"

    invoke-static {v0, v1}, Lcom/adobe/air/SSLSecurityDialog;->access$000(Lcom/adobe/air/SSLSecurityDialog;Ljava/lang/String;)V

    .line 159
    :cond_0
    const/4 v0, 0x0

    return v0
.end method
